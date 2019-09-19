# ##############################################################################
# ---- function to import the Trips file from OAB report ---------
# ##############################################################################
#' Import the Trips file from OAB report
#'
#' This function import the trips file obtained from OAB
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the trips filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABTrips <- function(file, path = getwd()){

  file_type <- "OAB_TRIPS"

  # fix files (view fixImportFiles help) and save the fixed temporal files in
  # a temporal directory with the original name of the file
  trips <- lapply(
    file,
    fixReportSirenoFiles,
    file_type,
    path,
    TRUE
    )

  # the fixed files are imported from the temporal directory
  trips <- lapply(
    file,
    importFileFromSireno,
    file_type,
    tempdir()
  )

  trips <- Reduce(rbind, trips)

  checkStructureFile(trips, file_type)

  trips <- renameFileVariables(trips, file_type)

  # This file has variables with comma as a decimal character: TRB, ESLORA
  trips <- replace_coma_with_dot(trips, "TRB")
  trips <- replace_coma_with_dot(trips, "ESLORA")

  trips <- formatVariableTypes(trips, file_type)

}
