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

  # Change FECHA_LAR y FECHA_VIR format from 16-JUN-19 TO 16/06/2019
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  hauls$FECHA_LAR <- format(as.Date(hauls$FECHA_LAR, "%d-%b-%y"), "%d/%m/%Y")
  hauls$FECHA_VIR <- format(as.Date(hauls$FECHA_VIR, "%d-%b-%y"), "%d/%m/%Y")

  # and come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  # create field with data and time format
  hauls[["FECHA_HORA_LAR"]] <- paste(hauls[["FECHA_LAR"]], hauls[["HORA_LAR"]])
  hauls[["FECHA_HORA_LAR"]] <- as.POSIXlt(hauls[["FECHA_HORA_LAR"]], format="%d/%m/%Y %H:%M")

  hauls[["FECHA_HORA_VIR"]] <- paste(hauls[["FECHA_VIR"]], hauls[["HORA_VIR"]])
  hauls[["FECHA_HORA_VIR"]] <- as.POSIXlt(hauls[["FECHA_HORA_VIR"]], format="%d/%m/%Y %H:%M")

  return(hauls)


}
