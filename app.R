#!/usr/bin/env Rscript

## ---- load packages ----

library(RestRserve)
library(jsonlite)


## bemtool libs preload
(source(paste(Sys.getenv("BEMTOOL_DIR"), "/src/utils/requiredLibs.r", sep="")))

## utils

is_uuid = function(x) {
  grepl("^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$", tolower(x))
}

## ---- create handler for the HTTP requests ----

# simple response
run_mcda = function(request, response) {
  setwd(paste(getwd(), Sys.getenv("BEMTOOL_DIR"), sep="/"))

print('*** LOADING BEMTOOL ***')
  source(paste(getwd(), "BEMTOOL_NO_GUI.r", sep="/"))
  print('*** BEMTOOL LOADED ***')

  MCDAutility_table <<- data.frame(read.csv(paste(getwd(), "src/mcda/Utility_params_default.csv", sep="/"), sep=";"))
  MCDAweight_table <<- read.csv(paste(getwd(), "src/mcda/Weights_default.csv", sep="/"), sep=";")

  MCDAutility_table$Value[16] <- ifelse(MCDAutility_table$Value[16] ==1, "GVA", ifelse(MCDAutility_table$Value[16] ==2, "ROI", "PROFITS"))

  Run_MCDA(MCDAweight_table, MCDAutility_table)

  response$body = "run_mcda!"
}

# simple response
hello_handler = function(request, response) {
  response$body = "Hello, World!"
}

# handle query parameter
heelo_query_handler = function(request, response) {
  # user name
  nm = request$parameters_query[["name"]]
  # default value
  if (is.null(nm)) {
    nm = "anonym"
  }
  response$body = sprintf("Hello, %s!", nm)
}

# handle path variable
hello_path_handler = function(request, response) {
  # user name
  nm = request$parameters_path[["name"]]
  response$body = sprintf("Hello, %s!", nm)
}

hello_path_handler = function(request, response) {
  # user name
  nm = request$parameters_path[["name"]]
  response$body = sprintf("Hello, %s!", nm)
}

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
  setwd(paste(getwd(), Sys.getenv("BEMTOOL_DIR"), sep="/"))

  ## run user input checks
  ## check uuid correctness
  if(!is_uuid(request$body$request_id)) {
     raise(HTTPError$bad_request())
  }
  print('*** LOADING BEMTOOL ***')
  source(paste(getwd(), "BEMTOOL_NO_GUI.r", sep="/"))
  print('*** BEMTOOL LOADED ***')

  ## TODO sanitize paths?
  request_id <- request$body$request_id
  MCDAutility_table <- request$body$weights
  MCDAweight_table <- request$body$utility_params

  MCDAutility_table$Value[16] <- ifelse(MCDAutility_table$Value[16] ==1, "GVA", ifelse(MCDAutility_table$Value[16] ==2, "ROI", "PROFITS"))

  print('Run_MCDA')
  Run_MCDA(MCDAweight_table, MCDAutility_table, request_id)
  out_path = save_path=paste(Sys.getenv("MCDA_SAVE_DIR"), request_id, sep='/')
  bemtool_uri = paste(Sys.getenv("BEMTOOL_PROTO"), "://", Sys.getenv("BEMTOOL_HOST"), ':', Sys.getenv("BEMTOOL_PORT"), sep="")
  response$body = to_json(paste(bemtool_uri, "mcda", request_id, list.files(out_path), sep="/"))

}

## ---- create application -----

## override default json decoding middleware

enc_dec_mw = EncodeDecodeMiddleware$new()

enc_dec_mw$ContentHandlers$set_decode("application/json",function(x){
  if (is.raw(x)) {
    x = rawToChar(x)
  }
return(fromJSON(x))})

app = Application$new(
  content_type = "text/plain",
  middleware = list(enc_dec_mw)
)


## ---- register endpoints and corresponding R handlers ----

app$add_get(
  path = "/mcda",
  FUN = run_mcda
)

app$add_get(
  path = "/hello",
  FUN = hello_handler
)

app$add_get(
  path = "/hello/query",
  FUN = heelo_query_handler
)

app$add_get(
  path = "/hello/path/{name}",
  FUN = hello_path_handler,
  match = "regex"
)

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
backend$start(app, http_port = 8080)