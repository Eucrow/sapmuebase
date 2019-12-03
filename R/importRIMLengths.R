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

  # Change FECHA_DESEM from 16-JUN-19 to 16/06/2019 format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  lengths$FECHA_DESEM <- format(as.Date(lengths$FECHA_DESEM, "%d-%b-%y"), "%d/%m/%Y")

  # and come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  return(lengths)

}
