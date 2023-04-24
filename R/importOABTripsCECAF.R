#' Import the CECAF Trips file from OAB report
#'
#' This function import the trips file obtained from OAB
#' reports in SIRENO from CECAF project.
#'
#' Multiple files can be imported at the same time.
#'
#' @param file vector with the trips filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABTripsCECAF <- function(file, path = getwd()){

  file_type <- "OAB_TRIPS_CECAF"

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
    sapmuebase:::importFileFromSireno,
    file_type,
    tempdir()
  )

  trips <- Reduce(rbind, trips)

  checkStructureFile(trips, file_type)

  trips <- sapmuebase:::renameFileVariables(trips, file_type)


  # This file has variables with comma as a decimal character: TRB, ESLORA
  trips <- sapmuebase:::replace_coma_with_dot(trips, "TRB")
  trips <- sapmuebase:::replace_coma_with_dot(trips, "ESLORA")

  trips <- sapmuebase:::formatVariableTypes(trips, file_type)

  # Change date format from, for example, 16-JUN-19 TO 16/06/2019
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  # format properly date variables
  trips$FECHA_EMB <- format(as.Date(trips$FECHA_EMB, "%d-%b-%y"), "%d/%m/%Y")
  trips$FECHA_DESEM <- format(as.Date(trips$FECHA_DESEM, "%d-%b-%y"), "%d/%m/%Y")

  # create fields with data and time format
  trips[["FECHA_HORA_INI_MAREA"]] <- paste(trips[["FECHA_INI_MAREA"]], trips[["HORA_INI_MAREA"]])
  trips[["FECHA_HORA_INI_MAREA"]] <- as.POSIXct(trips[["FECHA_HORA_INI_MAREA"]], format="%d/%m/%Y %H:%M")

  trips[["FECHA_HORA_FIN_MAREA"]] <- paste(trips[["FECHA_FIN_MAREA"]], trips[["HORA_FIN_MAREA"]])
  trips[["FECHA_HORA_FIN_MAREA"]] <- as.POSIXct(trips[["FECHA_HORA_FIN_MAREA"]], format="%d/%m/%Y %H:%M")


  # and come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  return(trips)

}
