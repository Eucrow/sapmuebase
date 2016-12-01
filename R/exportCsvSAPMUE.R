#' export csv with SAPMUE format
#'
#' The csv files usually used in SAPMUE have a special format:
#' - fields separation with ";"
#' - row header
#' - without quote characteres
#' - without row names
#' - decimal separator with ","
#'
#' This function allow the export with that format.
#'
#' @param df: dataframe to export
#' @param filename: name of the file to export without filename extension.
#' @export


exportCsvSAPMUEBASE <- function(df, filename){
  write.table(df, file=filename, quote = FALSE, row.names = FALSE, dec = ",", sep = ";")
}
