# ##############################################################################
# ---- function to import the Hauls file from OAB report ---------
# ##############################################################################
#' Import the Hauls file from OAB report
#'
#' This function import the hauls file obtained from OAB
#' reports in SIRENO. The SIRENO hauls report must be generated with the option
#' 'only hauls'.
#'
#' Multiple files can be imported at the same time.
#'
#' @note The SIRENO hauls report must be generated with the option 'only hauls'.
#' @param file vector with the hauls filenames.
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
