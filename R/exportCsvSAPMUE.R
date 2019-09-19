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
#' @param filename: name of the file to export (with filename extension).
#' @param path: path where the file must be exported. Current working directory
#' by default.
#' @export


exportCsvSAPMUEBASE <- function(df, filename, path = getwd()){

  filename <- paste(path, filename, sep="/")

  write.table(df, file=filename, quote = FALSE, row.names = FALSE, dec = ",", sep = ";", na = "")

}
