#' Fetch documentation files for all packages from a given R-universe
#'
#' @inheritParams get_pkgs_metadata
#' @param destdir Path where the documentation files should be written (defaults
#'   to `"docs"`).
#'
#' @returns This function is called for its side effect. The documentation files
#'   (individual function documentation under `man/` and vignettes) are stored
#'   on the file system, in the folder specified in `destdir`, with the specific
#'   folder structure:
#' ```
#' docs
#' ├── pkg1
#' │   └── man
#' │       ├── fun1.md
#' │       ├── fun2.md
#' │       └── fun3.md
#' └── pkg2
#'     ├── man
#'     │   ├── fct1.md
#'     │   ├── fct2.md
#'     └── vignettes
#'         ├── vig_a.Rmd
#'         ├── vig_b.Rmd
#' ```
#'
#' @importFrom utils download.file untar unzip
#'
#' @export
get_universe_docs <- function(universe = "epiverse-connect", destdir = "docs") {

  if (!dir.exists(destdir)) {
    dir.create(destdir)
  }

  docs_zip_path <- withr::local_tempfile(pattern = "pkgdocs", fileext = ".zip")
  download.file(
    glue::glue("https://{universe}.r-universe.dev/api/snapshot/zip?types=src"),
    docs_zip_path
  )

  tarballs <- withr::local_tempdir(pattern = "tarballs")
  sources <- unzip(docs_zip_path, exdir = tarballs)

  sources |>
    purrr::discard(\(x) grepl("PACKAGES(\\.gz)?$", basename(x))) |>
    purrr::walk(get_pkg_docs, destdir = destdir)

}

get_pkg_docs <- function(tarball_path, destdir) {

  withr::local_dir(destdir)

  source_files <- untar(tarball_path, list = TRUE)

  fct_docs_to_extract <- grepv(
    "/man/[^/]*\\.Rd$",
    source_files
  )
  vignettes_to_extract <- grepv(
    "/vignettes/.*\\.R?md$",
    source_files
  )

  untar(tarball_path, files = c(fct_docs_to_extract, vignettes_to_extract))

  fct_docs_to_extract |>
    purrr::map(function(file) {
      rd2markdown::get_rd(file = file) |>
        rd2markdown::rd2markdown() |>
        writeLines(gsub("\\.Rd$", ".md", file))
    })

  file.remove(fct_docs_to_extract)

}
