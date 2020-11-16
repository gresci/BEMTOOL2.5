#!/usr/bin/env Rscript

## ---- load packages ----

library(RestRserve)
library(jsonlite)


## bemtool libs preload
print('*** LOADING BEMTOOL ***')
source(paste('/app',Sys.getenv("BEMTOOL_DIR"), "src/utils/requiredLibs.r", sep="/"))
setwd(paste(getwd(), Sys.getenv("BEMTOOL_DIR"), sep="/"))
source(paste('/app', Sys.getenv("BEMTOOL_DIR"), "BEMTOOL_NO_GUI.r", sep="/"))
print('*** BEMTOOL LOADED ***')
## utils

is_uuid = function(x) {
  grepl("^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$", tolower(x))
}

## ---- create handler for the HTTP requests ----

mcda_get_products_handler = function(request, response) {
  ## TODO sanitize paths
  request_id <- request$parameters_path[["request_id"]]
  product_id <- request$parameters_path[["product_id"]]
  product_path <- paste(Sys.getenv("MCDA_SAVE_DIR"), request_id, product_id, sep="/")
  if(!dir.exists(paste(Sys.getenv("MCDA_SAVE_DIR"), request_id, sep="/"))) {
     ## handle error request not found
     raise(HTTPError$not_found())
  }
  if(!file.exists(product_path)) {
     ## handle error product not found
     raise(HTTPError$not_found())
  }
  response$body = c(file = product_path)
  response$status_code = 200L
}

run_mcda_post = function(request, response) {
  ## run user input checks
  ## check uuid correctness
  if(!is_uuid(request$body$request_id)) {
     raise(HTTPError$bad_request())
  }

  ## TODO sanitize paths?
  request_id <- request$body$request_id
  MCDAutility_table <- request$body$utility_params
  MCDAweight_table <- request$body$weights

  MCDAutility_table$Value[16] <- ifelse(MCDAutility_table$Value[16] ==1, "GVA", ifelse(MCDAutility_table$Value[16] ==2, "ROI", "PROFITS"))

  print('Running MCDA')
  Run_MCDA(MCDAweight_table, MCDAutility_table, request_id)
  out_path = paste(Sys.getenv("MCDA_SAVE_DIR"), request_id, sep='/')
  bemtool_uri = Sys.getenv("BEMTOOL_URL")
  file_list = list.files(out_path)
  file_path = paste(bemtool_uri, request_id, file_list, sep="/")
  df <- data.frame(file_path)
  df$name <- gsub("\\..+$", "", file_list)
  df$type <- gsub("^.+\\.", "", file_list)
  response$set_content_type("application/json")
  response$body = df

}

## ---- create application -----

## override default json decoding middleware

cors = CORSMiddleware$new()

enc_dec_mw = EncodeDecodeMiddleware$new()

enc_dec_mw$ContentHandlers$set_decode("application/json",function(x){
  if (is.raw(x)) {
    x = rawToChar(x)
  }
return(fromJSON(x))})
enc_dec_mw$ContentHandlers$set_encode("application/json",function(x){
return(toJSON(x))})

app = Application$new(
  content_type = "text/plain",
  middleware = list(enc_dec_mw,cors)
)

## ---- register endpoints and corresponding R handlers ----

app$add_post(
  path = "/mcda",
  FUN = run_mcda_post
)

app$add_get(
   path = "/mcda/{request_id}/{product_id}",
   FUN = mcda_get_products_handler,
   match = "regex"
)

## ---- start application ----
backend = BackendRserve$new()
backend$start(app, http_port = as.integer(Sys.getenv("BEMTOOL_PORT")))