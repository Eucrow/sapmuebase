#' Import SIRENO lengths report from at-market sampling in the ICES project.
#'
#' This function import the catches files obtained from 'muestreos tallas por up'
#' reports in SIRENO of ICES project.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and
#' 'TRIMESTRE' are created in the returned data frame.
#'
#' @param file vector with the file names.
#' @param path path of the files. The working directory by default.
#' @return Return data frame.
#' @aliases importLengths
#' @export
importRIMLengths <- function(file, path = getwd()){

  file_type <- "RIM_LENGTHS"

  lengths <- lapply(
    file,
    importFileFromSireno,
    file_type,
    path
  )

  lengths <- Reduce(rbind, lengths)

  checkStructureFile(lengths, file_type)

  # Change FECHA_DESEM from 16-JUN-19 to 16/06/2019 format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  lengths$FECHA_DESEM <- format(as.Date(lengths$FECHA_DESEM, "%d-%b-%y"), "%d/%m/%Y")
  lengths$FECHA_MUE <- format(as.Date(lengths$FECHA_MUE, "%d-%b-%y"), "%d/%m/%Y")

  # and come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  # format variables
  lengths <- formatVariableTypes(lengths, file_type)

  # Other corrections (imperative do it at the end, because new variables are
  # added)
  lengths <- add_dates_variables(lengths)
  lengths <- remove_coma_in_category(lengths)

  return(lengths)

}
