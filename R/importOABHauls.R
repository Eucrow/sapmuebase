# ##############################################################################
# ---- function to import the Hauls file from OAB report ---------
# ##############################################################################
#' Import the Hauls file from OAB report
#'
#' This function import the hauls file obtained from OAB
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the hauls filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABHauls <- function(file, path = getwd()){

  file_type <- "OAB_HAULS"

  hauls <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  hauls <- Reduce(rbind, hauls)

  checkStructureFile(hauls, file_type)

  hauls <- renameFileVariables(hauls, file_type)

  hauls <- fixCuadriculaICES(hauls)

}
