
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

### Package documentation

To get the documentation of packages listed under, e.g., the https://epiverse-connect.r-universe.dev/ universe,
and save it under the `docs/` folder,
you can run:

```r
get_universe_docs(universe = "epiverse-connect", destdir = "docs")
```

You will then get the following folder structure:

```
docs
├── adegenet
│   └── man
│       ├── AIC.snapclust.md
│       ├── AICc.md
    .
    .
    .
│       ├── web.md
│       └── xvalDapc.md
└── aedseo
    ├── man
    │   ├── aedseo-package.md
    .
    .
    .
    │   └── tsd.md
    └── vignettes
        ├── aedseo.Rmd
        ├── burden_levels.Rmd
        ├── generate_seasonal_wave.Rmd
        └── seasonal_onset.Rmd
```