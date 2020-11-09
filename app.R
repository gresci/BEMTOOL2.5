#!/usr/bin/env Rscript

## ---- load packages ----

library(RestRserve)

## ---- create handler for the HTTP requests ----

# simple response
run_mcda = function(request, response) {
  setwd(paste(getwd(), Sys.getenv("BEMTOOL_DIR"), sep="/"))

  print('*** LOADING BEMTOOL ***')
  source(paste(getwd(), "BEMTOOL_NO_GUI.r", sep="/"))
  print('*** BEMTOOL LOADED ***')

  MCDAutility_table <<- data.frame(read.csv(paste(getwd(), "src/mcda/Utility_params_default.csv", sep="/"), sep=";"))
  MCDAweight_table <<- read.csv(paste(getwd(), "src/mcda/Weights_default.csv", sep="/"), sep=";")

  write.table(MCDAweight_table, file= paste(getwd(), "src/mcda/Weights.csv", sep="/"), sep=";", row.names=F )
  MCDAutility_table$Value[16] <- ifelse(MCDAutility_table$Value[16] ==1, "GVA", ifelse(MCDAutility_table$Value[16] ==2, "ROI", "PROFITS"))
  write.table(MCDAutility_table, paste(getwd(), "src/mcda/Utility_params.csv", sep="/"), sep=";", row.names=F)

  print('Run_MCDA')
  Run_MCDA()
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


## ---- create application -----

app = Application$new(
  content_type = "text/plain"
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


## ---- start application ----
backend = BackendRserve$new()
backend$start(app, http_port = 8080)