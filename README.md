
<!-- README.md is generated from README.Rmd. Please edit that file -->

# poemReport

The goal of poemReport is to make reporting of statistical services
automatic.

## Installation

You can install the released version of poemReport from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("devtools")
devtools::install_github("dpananos/poemReport")
```

## Reporting

To begin the delays analysis for a given month, use
`poemReport::setup()`:

``` r
poemReport::setup(report_month = "January", 
                    report_year = "2019")
```
