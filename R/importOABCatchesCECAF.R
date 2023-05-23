#' Import SIRENO catches report from on-board sampling in the CECAF project.
#'
#' This function import the catches file obtained from on-board
#' reports in SIRENO of CECAF project. The SIRENO catches report must be
#' generated with the option 'by category'.
#'
#' Multiple files can be imported at the same time.
#'
#' @note The SIRENO catches report must be generated with the option
#' 'by category'.
#' @param file vector with the file names.
#' @param path path of the files. The working directory by default.
#' @return Return data frame.
#' @export
importOABCatchesCECAF <- function(file, path = getwd()){

  file_type <- "OAB_CATCHES_CECAF"

  catches <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  catches <- Reduce(rbind, catches)

  checkStructureFile(catches, file_type)

  catches <- renameFileVariables(catches, file_type)

  # This file has variable with comma as a decimal character: TAMAÑO_MALLA
  catches <- replace_coma_with_dot(catches, "TAMANO_MALLA")

  catches <- fixCuadriculaICES(catches)

  catches <- formatVariableTypes(catches, file_type)

}
