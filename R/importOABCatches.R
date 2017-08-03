# ##############################################################################
# ---- function to import the Catches file from OAB report ----------------
# ##############################################################################
#' Import the Catches file from OAB report
#'
#' This function import the catches file obtained from OAB
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the catches filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABCatches <- function(file, path = getwd()){

  file_type <- "OAB_CATCHES"

  catches <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  catches <- Reduce(rbind, catches)

  checkStructureFile(catches, file_type)

  catches <- renameFileVariables(catches, file_type)

  catches <- fixCuadriculaICES(catches)

}
