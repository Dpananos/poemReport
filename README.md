
<!-- README.md is generated from README.Rmd. Please edit that file -->

# poemReport

The goal of poemReport is to make reporting of statistical services
automatic.

## Installation

You can install poemReport using

``` r
install.packages("devtools")
devtools::install_github("dpananos/poemReport")
```

## Reporting

To begin the delays analysis for a given month, use
`poemReport::setup()`:

``` r
# Insert the appropirate month and year of the report
poemReport::setup(report_month = "May", 
                    report_year = "2020")
```

This will open a `.R` file which looks like

``` r
# Create POEM Report for May 2020


poemReport::data_cleaning(report_month = "May", report_year = "2020")
#> ✓ Setting active project to '/Users/demetri/The University of Western Ontario/Susan Dimitry - Stats Analyst Service/poemReport'

poemReport::poem_report(report_month = "May", report_year = "2020", render = FALSE)
#> ✓ Writing 'reports/2020/May/03-poem_report.Rmd'
#> ● Edit 'reports/2020/May/03-poem_report.Rmd'
```

Running `poemReport::data_cleaning(report_month = "May", report_year =
"2020")` opens a cleaning script called `02-data_cleaning.R`. Analysts
are required to point the script towards the appropriate databases in
order to analyze them. The remainder of the script implements analyses
for statistical services data. The analyst is free to add/remove/change
any of the analyses as they see fit.

Running `02-data_cleaning.R` will save a copy of the clean data in a
`.RDS` file into the working directory. The report can be created by
running `poemReport::poem_report(report_month = "May", report_year =
"2020", render = TRUE)`.
