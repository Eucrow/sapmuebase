# ---- function to import the Lengths file from 'tallas por up' report ---------
#' Import the Lenghts file from 'tallas por up' report
#'
#' This function import the lengths files obtained from 'muestreos tallas por up'
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' are created in the returned dataframe.
#'
#' @param file vector with the total landings filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @aliases importLengths
#' @export
importRIMLengths <- function(file, path = getwd()){

  file_type <- "RIM_LENGTHS"

  lengths <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  lengths <- Reduce(rbind, lengths)

  checkStructureFile(lengths, file_type)

  lengths <- formatImportedFile(lengths)
}
