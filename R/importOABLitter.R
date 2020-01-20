#' Import the Litter file from OAB report
#'
#' This function import the Litter file obtained from SIRENO OAB reports.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the Litter filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
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

  litter <- formatVariableTypes(litter, file_type)

}
