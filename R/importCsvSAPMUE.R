#' import csv with SAPMUE format
#'
#' The csv files usually used in SAPMUE have a special format:
#' - fields separation with ";"
#' - row header
#' - sometimes the rows have unequal length
#'
#' This function allow the import with that format.
#'
#' @param filename: name of the file to be imported.
#' @return A dataframe with the content of the csv, with column names and with
#' blank fields in rows with unequal length.
#' @export

ImportCsvSAPMUE <- function(filename){
  file <- read.table(file=filename, head=TRUE, sep=";", fill=TRUE)
}
