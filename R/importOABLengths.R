# ##############################################################################
# ---- function to import the Lengths file from OAB report ----------------
# ##############################################################################
#' Import the Lengths file from OAB report
#'
#' This function import the lengths file obtained from OAB
#' reports in SIRENO. The SIRENO Lengths report must be generated by categories.
#'
#' Multiple files can be imported at the same time.
#'
#' @note The SIRENO Lengths report must be generated by categories.
#' @param file vector with the catches filenames.
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABLengths <- function(file, path = getwd()){

  file_type <- "OAB_LENGTHS"

  lengths <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  lengths <- Reduce(rbind, lengths)

  checkStructureFile(lengths, file_type)

  lengths <- renameFileVariables(lengths, file_type)

  # This file has variable with comma as a decimal character: TAMANO_MALLA
  lengths <- replace_coma_with_dot(lengths, "TAMANO_MALLA")

  lengths <- fixCuadriculaICES(lengths)

  lengths <- formatVariableTypes(lengths, file_type)

}
