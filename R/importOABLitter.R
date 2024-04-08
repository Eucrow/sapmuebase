#' Import SIRENO litter report from on-board sampling in the ICES project.
#'
#' This function import the litter file obtained from SIRENO OAB reports of ICES
#' project.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the file names.
#' @param path path of the files. The working directory by default.
#' @return Return data frame.
#' @export
importOABLitter <- function(file, path = getwd()){

  file_type <- "OAB_LITTER"

  # fix files (view fixImportFiles help) and save the fixed temporal files in
  # a temporal directory with the original name of the file
  litter <- lapply(
    file,
    fixReportSirenoFiles,
    file_type,
    path,
    TRUE
  )

  # the fixed files are imported from the temporal directory
  litter <- lapply(
    file,
    importFileFromSireno,
    file_type,
    tempdir()
  )

  litter <- Reduce(rbind, litter)

  checkStructureFile(litter, file_type)

  litter <- renameFileVariables(litter, file_type)

  # format variables
  litter <- formatVariableTypes(litter, file_type)

  return(litter)

}
