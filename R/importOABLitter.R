# ##############################################################################
# ---- function to import the Litter file from OAB report ----------------
# ##############################################################################
#' Import the Litter file from OAB report
#'
#' This function import the litter file obtained from OAB
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' @note The SIRENO catches report must be generated with the option 'by category'
#' @param file vector with the catches filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importOABLitter <- function(file, path = getwd()){

  file_type <- "OAB_LITTER"

  litter <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  litter <- Reduce(rbind, litter)

  checkStructureFile(litter, file_type)

  litter <- renameFileVariables(litter, file_type)

  litter <- formatVariableTypes(litter, file_type)

}
