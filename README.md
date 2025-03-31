
# epiverse.scraper

<!-- badges: start -->
[![R-CMD-check](https://github.com/epiverse-connect/epiverse-scraper/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/epiverse-connect/epiverse-scraper/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This repository contains code to, for a given [R-universe](https://r-universe.dev/):

- Extract all package documentation (both long-form tutorials as vignettes, and individual function documentation)
- Extract all package metadata (title, description, logo, link to source code, etc.)

## Installation

You can install the development version of this package from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("epiverse-connect/epiverse-scraper")
```

## Usage

### Metadata

To get the metadata from, e.g., the https://epiverse-connect.r-universe.dev/ universe,
and save it as JSON,
you can run:

```r
get_pkgs_metadata(universe = "epiverse-connect") |>
  jsonlite::write_json("epiverse-connect-metadata.json", pretty = TRUE)
```
