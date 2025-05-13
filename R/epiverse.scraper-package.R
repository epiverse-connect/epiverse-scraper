#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
ignore_unused_imports <- function() {
  # Make jsonlite dependency explicit:
  # It is listed as an optional dependency in httr2 but it is actually required
  # by httr2::resp_body_json()
  jsonlite::minify
}