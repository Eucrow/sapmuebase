# ---- function to import the 'Catches' file from 'tallas por up' report ---------
#' Import the 'Catches' file from 'tallas por up' report
#'
#' This function import the 'Catches' files obtained from 'muestreos tallas por up'
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' are created in the returned dataframe.
#'
#' @param file vector with the catches report filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @aliases importCatches
#' @export
importRIMCatches <- function(file, path = getwd()){

  file_type <- "RIM_CATCHES"

  # fix files (view fixImportFiles help) and save the fixed temporal files in
  # a temporal directory with the original name of the file
  catches <- lapply(
    file,
    fixReportSirenoFiles,
    file_type,
    path,
    TRUE
  )

  # the fixed files are imported from the temporal directory
  catches <- lapply(
    file,
    importFileFromSireno,
    file_type,
    tempdir()
  )

  catches <- Reduce(rbind, catches)

  checkStructureFile(catches, file_type)

  catches <- formatImportedFile(catches)

  # Change FECHA_DESEM from 16-JUN-19 to 16/06/2019 format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  catches$FECHA_DESEM <- format(as.Date(catches$FECHA_DESEM, "%d-%b-%y"), "%d/%m/%Y")

  # and come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  return(catches)

}






