#' Import SIRENO accidentals catches report from on-board sampling in the ICES
#' project.
#'
#' This function import the accidentals catches file obtained from SIRENO
#' on-board reports.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the file names.
#' @param path path of the files. The working directory by default.
#' @return Return data frame.
#' @export
importOABAccidentals <- function(file, path = getwd()){

  file_type <- "OAB_ACCIDENTALS"

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
