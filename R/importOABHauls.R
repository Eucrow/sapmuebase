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

  # fix files (view fixImportFiles help) and save the fixed temporal files in
  # a temporal directory with the original name of the file
  hauls <- lapply(
    file,
    fixReportSirenoFiles,
    file_type,
    path,
    TRUE
  )

  # the fixed files are imported from the temporal directory
  hauls <- lapply(
    file,
    importFileFromSireno,
    file_type,
    tempdir()
  )

  hauls <- Reduce(rbind, hauls)

  checkStructureFile(hauls, file_type)

  hauls <- renameFileVariables(hauls, file_type)

  # This file has variables with comma as a decimal character: TAMAÑO_MALLA,
  # ABERTURA_VER and ABERTURA_HOR
  hauls <- replace_coma_with_dot(hauls, "TAMANO_MALLA")
  hauls <- replace_coma_with_dot(hauls, "ABERTURA_VER")
  hauls <- replace_coma_with_dot(hauls, "ABERTURA_HOR")

  hauls <- fixCuadriculaICES(hauls)

  hauls <- formatVariableTypes(hauls, file_type)

}
