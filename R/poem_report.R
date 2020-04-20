#' Generate template for creating poem report
#'
#' @description Opens a template of the poem report for the month, optionally rendering it.
#'
#' @param report_month Month of report
#' @param report_year Year of report
#' 
#'
#' @export
poem_report <- function(report_month, report_year){
  report_path <- fs::path("reports", report_year, report_month)
  
  usethis::use_template(template = "poem_report.Rmd",
                        save_as = paste0(report_path, "/03-poem_report.Rmd"),
                        data = list(report_month = report_month,
                                    report_year = report_year),
                        package = "poemReport",
                        open = TRUE)
}