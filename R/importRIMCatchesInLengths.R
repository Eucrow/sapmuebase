# ---- function to import the 'Catches in Lengths' file from 'tallas por up' report ---------
#' Import the 'Catches in Lengths' file from 'tallas por up' report
#'
#' This function import the 'Catches in Lengths' files obtained from 'muestreos tallas por up'
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' are created in the returned dataframe.
#'
#' @param file vector with the total landings filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @aliases importCatchesInLengths
#' @export
importRIMCatchesInLengths <- function(file, path = getwd()){

  file_type <- "RIM_CATCHES_IN_LENGTHS"

  catches_in_lengths <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  catches_in_lengths <- Reduce(rbind, catches_in_lengths)

  checkStructureFile(catches_in_lengths, file_type)

  catches_in_lengths <- formatImportedFile(catches_in_lengths)

}
