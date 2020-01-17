# ##############################################################################
# ---- function to import the Catches file from OAB report ----------------
# ##############################################################################
#' Import the Catches file from OAB report
#'
#' This function import the catches file obtained from OAB
#' reports in SIRENO. The SIRENO catches report must be generated with the
#' option 'by category'
#'
#' Multiple files can be imported at the same time.
#'
#' @note The SIRENO catches report must be generated with the option 'by category'
#' @param file vector with the catches filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABCatches <- function(file, path = getwd()){

  file_type <- "OAB_CATCHES"

  tryCatch(
    sirenoReportEmpty(file, file_type, path),
    error = function(e){
      stop(e)
    }
  )

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
