#' Import SIRENO catches in lengths report from at-market sampling in the ICES
#' project.
#'
#' This function import the catches in lengths files obtained from 'muestreos
#' tallas por up' reports in SIRENO of ICES project.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and
#' 'TRIMESTRE' are created in the returned data frame.
#'
#' @param file vector with file names.
#' @param path path of the files. The working directory by default.
#' @return Return data frame.
#' @aliases importCatchesInLengths.
#' @export
importRIMCatchesInLengths <- function(file, path = getwd()){

  file_type <- "RIM_CATCHES_IN_LENGTHS"

  # fix files (view fixImportFiles help) and save the fixed temporal files in
  # a temporal directory with the original name of the file
  catches_in_lengths <- lapply(
    file,
    fixReportSirenoFiles,
    file_type,
    path,
    TRUE
  )

  # the fixed files are imported from the temporal directory
  catches_in_lengths <- lapply(
    file,
    importFileFromSireno,
    file_type,
    tempdir()
  )

  catches_in_lengths <- Reduce(rbind, catches_in_lengths)

  checkStructureFile(catches_in_lengths, file_type)

  # Change FECHA_DESEM from 16-JUN-19 to 16/06/2019 format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  catches_in_lengths$FECHA_DESEM <- format(as.Date(catches_in_lengths$FECHA_DESEM, "%d-%b-%y"), "%d/%m/%Y")
  catches_in_lengths$FECHA_MUE <- format(as.Date(catches_in_lengths$FECHA_MUE, "%d-%b-%y"), "%d/%m/%Y")

  # and come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  # format variables
  catches_in_lengths <- formatVariableTypes(catches_in_lengths, file_type)

  # Other corrections (imperative do it at the end, because new variables are
  # added)
  catches_in_lengths <- add_dates_variables(catches_in_lengths)
  catches_in_lengths <- remove_coma_in_category(catches_in_lengths)

  return(catches_in_lengths)

}
