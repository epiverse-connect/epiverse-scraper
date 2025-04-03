#' List of metadata for all packages from a given R-universe
#'
#' @param universe Name of the r-universe to explore
#'
#' @returns A list of list where each element refers to a specific package and
#'   contains the following elements:
#'   - `Package` (character): package name
#'   - `logo` (character): Link to the package logo
#'   - `website` (character): Link to the documentation website
#'   - `source` (character): Link to the package source
#'   - `articles` (character vector): Links to the package vignettes
#'
#' @export
get_universe_metadata <- function(universe = "epiverse-connect") {

  package_metadata <- glue::glue("https://{universe}.r-universe.dev/api/packages") |>
    httr2::request() |>
    httr2::req_user_agent("epiverse-connect metadata collection script") |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  package_metadata <- package_metadata |>
    purrr::map(\(x) {
      x$articles <- unlist(purrr::map(x$`_vignettes`, "filename"))
      x$articles <- glue::glue("https://{universe}.r-universe.dev/articles/{x$Package}/{x$articles}")
      x$URL_list <- stringr::str_split(x$URL, "[,\\n[:space:]]+")
      # First URL that doesn't look like a link to a GitHub repo
      x$docs_URL <- purrr::map_chr(x$URL_list, ~ .x[match(FALSE, startsWith(.x, "https://github.com"))])

      x <- x[c("Package", "Title", "Description", "_pkglogo", "docs_URL", "RemoteUrl", "articles")]
      names(x) <- c("package", "title", "description", "logo", "website", "source", "articles")
      return(x)
    })

  return(package_metadata)

}
