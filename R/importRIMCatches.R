# ---- function to import the 'Catches' file from 'tallas por up' report ---------
#' Import the 'Catches' file from 'tallas por up' report
#'
#' This function import the 'Catches' files obtained from 'muestreos tallas por up'
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' are created in the returned dataframe.
#'
#' @param file vector with the catches report filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @aliases importCatches
#' @export
importRIMCatches <- function(file, path = getwd()){

  file_type <- "RIM_CATCHES"

  catches <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  catches <- Reduce(rbind, catches)

  checkStructureFile(catches, file_type)

  catches <- formatImportedFile(catches)

}






