#' Generate template for creating poem report
#'
#' @description Opens a template of the poem report for the month, optionally rendering it.
#'
#' @param report_month Month of report
#' @param report_year Year of report
#' @param render Should the report be rendered automatically? Defaults to `FALSE`
#'
#' @export
poem_report <- function(report_month, report_year, render = FALSE){
  report_path <- fs::path("reports", report_year, report_month)
  
  usethis::use_template(template = "poem_report.Rmd",
                        save_as = paste0(report_path, "/03-poem_report.Rmd"),
                        data = list(report_month = report_month,
                                    report_year = report_year),
                        package = "poemReport",
                        open = !render)
  
  if(render){
    out_path <- paste0(report_path, "/", report_month, " ", report_year, " ",
                       "report.pdf")
    
    rmarkdown::render(input = paste0(report_path, "/03-poem_report.Rmd"),
                      output_file = paste(report_month, report_year, "report.pdf"),
                      quiet = TRUE)
    
    usethis::ui_done("Report saved to {usethis::ui_path(out_path)}")
  }
}