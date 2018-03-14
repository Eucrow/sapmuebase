#' Import IPD file
#'
#' This function import the data of biological samples saved by IPD. Only import
#' record of the samples of ICES proyect.
#' @param filename name of the IPD file
#' @param by_month to filter only by one month. If false nothing is filtered. False by default.
#' @param path = destiny path. By default is the actual working directory.
#' @return Return data frame.
#' @export

importIPDFile <- function(filename, by_month = FALSE, path = getwd()){

  fullpath<-paste(path, filename, sep="/")

  #read the file
  records <- read.fwf(
    file=fullpath,
    widths=c(10,  4,  6,  3,
             3, 21, 10, 20,
             1, 10,  8,  7,
             7,  4, 20,  5,
             20, 10,  4, 20,
             5,  1, 20, 20,
             10, 10, 10, 10,
             200, 8),
    strip.white = TRUE,
    dec = ",",

    colClasses =  c (      NA, "factor", "factor", "factor",
                           "factor", "factor", "factor", "factor",
                           NA,       NA, "factor",       NA,
                           NA,       NA, "factor", "factor",
                           NA,       NA, "factor", "factor",
                           "factor",       NA, "factor", "factor",
                           NA,       NA, "factor", NA,
                           "character", "factor")
  )

  colnames(records) <- c("FECHA",       "COD_PUERTO",   "COD_BARCO",          "COD_ARTE",
                         "COD_ORIGEN",  "ESTRATO_RIM",  "COD_PROYECTO",       "COD_TIPO_MUE",
                         "N_RECHAZOS",  "N_BARCOS",     "COD_CUADRICULA",     "LATITUD",
                         "LONGITUD",    "DIAS_MAR",     "P_DESEM",            "COD_ESP_MUE",
                         "TIPO_MUE",    "PROCEDENCIA",  "COD_CATEGORIA",      "P_MUE_DESEM",
                         "COD_ESP_CAT", "SEXO",         "PESO_MUESTRA",       "MEDIDA",
                         "TALLA",       "EJEM_MEDIDOS", "COD_PUERTO_DESCARGA", "FECHA_DESEM",
                         "OBSERVACIONES", "COD_MUESTREADOR")

  # select only samples from ICES
  records <- records[records$COD_PROYECTO==1101001,]

  # format FECHA and FECHA_DESEMBARCO
  records$FECHA <- as.POSIXlt(records$FECHA, format="%d/%m/%Y")
  records$FECHA_DESEM <- as.POSIXlt(records$FECHA_DESEM, format="%d/%m/%Y")


  # format columns as numeric:
  # create a function to format the numeric columns imported by default as character
  # TODO: allow a list of characters to apll in various columns
  format_numeric <- function (df, col){
    df[col] <- lapply(df[col], function(x){(gsub("\\.", "", x))})
    df[col] <- lapply(df[col], function(x){(gsub(",", "\\.", x))})
    df[col] <- as.numeric(df[[col]])
    return(df)
  }

  # format columns as numeric:
  records <- format_numeric(records, "P_DESEM")
  records <- format_numeric(records, "P_MUE_DESEM")
  records <- format_numeric(records, "PESO_MUESTRA")

  # select by month:
  if (by_month >= 1 || by_month <= 12){
    records <- subset(records, FECHA$mon == by_month-1)
  } else if (by_month == FALSE){

  } else {
    stop("error in month selected")
  }

  # convert data format:
  records[["FECHA"]] <- as.POSIXct(records[["FECHA"]])
  records[["FECHA_DESEM"]] <- as.POSIXct(records[["FECHA_DESEM"]])
  records[["FECHA"]] <- format(records[["FECHA"]], "%d/%m/%Y")
  records[["FECHA_DESEM"]] <- format(records[["FECHA_DESEM"]], "%d/%m/%Y")


  # return data
  return(records)
}
