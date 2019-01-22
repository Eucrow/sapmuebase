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

  # trips <- lapply(
  #   file,
  #   # cannot use importFileFromSireno() function because the OAB_TRIPS have columns
  #   # with comma as a decimal character
  #   function(x){
  #     tryCatch({
  #       fullpath <- file.path(path, x)
  #       struct <- getStructureFiles(fullpath, file_type)
  #       type <- struct[["class_variable_final"]]
  #
  #       read.table(fullpath, sep=";", header = TRUE, quote = "", dec = ",", colClasses = type)
  #
  #     },
  #     error = function(err) {
  #       error_text <- paste("error in file", x, ": ", err)
  #       stop(error_text)
  #     }
  #     )
  #   }
  # )

  trips <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  trips <- Reduce(rbind, trips)

  checkStructureFile(trips, file_type)

  trips <- renameFileVariables(trips, file_type)

  # This file has variables with comma as a decimal character: TRB, ESLORA
  variables <- c("TRB", "ESLORA")
  lapply(variables, function(x){
    trips <- replace_coma_with_dot(trips, x)
  })

  trips <- formatVariableTypes(trips, file_type)

}
