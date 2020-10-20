#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

#* @apiTitle Penang data validation

#* Transform data
#* @post /penang-catch-validation
#* @param message a pub/sub message
function(message=NULL){

  cat("Received message", as.character(list(message = message)),"\n")

  # If message has not been properly parsed, address that
  if (class(message) == "character") {
    message <- jsonlite::fromJSON(message)
  }

  # Only continue if object has been created or overwritten
  if (message$attributes$eventType == "OBJECT_DELETE") {
    message("Notification of object deleted received")
    return(TRUE)
  }

  # Check that we know about that dataset
  this_bucket_datasets <- purrr::keep(
    .x = params$datasets,
    .p = ~ .$bucket==message$attributes$bucketId)
  if (length(this_bucket_datasets) == 0)
    stop("This bucket is not supported for auto-transformation")

  googleCloudRunner::cr_plumber_pubsub(message, validate_data)
}

validate_data <- function(x){
  # If message has not been properly parsed, address that
  if (class(x) == "character") {
    x <- jsonlite::fromJSON(x)
  }

  cat("Data parameters:", as.character(list(data = x)), "\n")

  return("hello world")
}
