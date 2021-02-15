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

  # Change variable from 16-JUN-19 to 16/06/2019 format
  catches$FECHA_DESEM <- dbyToDmy(catches$FECHA_DESEM)
  catches$FECHA_MUE <- dbyToDmy(catches$FECHA_MUE)

  # format variables
  catches <- formatVariableTypes(catches, file_type)

  # Other corrections (imperative do it at the end, because new variables are
  # added)
  catches <- add_dates_variables(catches)
  catches <- remove_coma_in_category(catches)

  return(catches)

}






