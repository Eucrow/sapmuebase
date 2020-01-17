#' Import the Litter file from OAB report
#'
#' This function import the Accidentals file obtained from SIRENO OAB reports.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the Accidentals filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABAccidentals <- function(file, path = getwd()){

  file_type <- "OAB_ACCIDENTALS"

  tryCatch(
    sirenoReportEmpty(file, file_type, path),
    error = function(e){
      stop(e)
    }
  )

  accidentals <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  accidentals <- Reduce(rbind, accidentals)

  checkStructureFile(accidentals, file_type)

  accidentals <- renameFileVariables(accidentals, file_type)
  # This file has variable with comma as a decimal character: PESO
  accidentals <- replace_coma_with_dot(accidentals, "PESO")

  accidentals <- formatVariableTypes(accidentals, file_type)

}
