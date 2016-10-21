# ---- function to import the IPD file -----------------------------------------
#' Import IPD file
#'
#' This function import the data of biological samples keyed by IPD
#' @param filename name of the IPD file
#' @param by_month to filter only by one month. If false nothing is filtered. False by default.
#' @return Return a data frame.
#' @export

import_IPD_file <- function(filename, by_month = FALSE){

  fullpath<-paste(getwd(), filename, sep="/")

  #read the file
  records <- read.fwf(
    file=fullpath,
    widths=c(10, 4, 6, 3, 3, 21, 10, 20, 1, 10, 8,  7, 7, 4, 20, 5, 20, 10, 4, 20, 5, 1, 20, 20, 10, 10, 10),
    strip.white = TRUE,
    dec = ",",
    colClasses =  c (NA, "factor", "factor", "factor",
                  "factor", "factor", "factor", "factor",
                  NA, NA, "factor",
                  NA, NA, NA, NA,
                  "factor", NA, NA, "factor",
                  NA, "factor", NA, NA, NA,
                  NA, NA, "factor")
  )

  colnames(records) <- c("FECHA", "COD_PUERTO", "COD_BARCO", "COD_ARTE",
                         "COD_ORIGEN", "ESTRATO_RIM", "COD_PROYECTO", "COD_TIPO_MUE",
                         "N_RECHAZOS", "N_BARCOS", "COD_CUADRICULA",
                         "LATITUD", "LONGITUD", "DIAS_MAR", "P_DESEM",
                         "COD_ESP_MUE", "TIPO_MUE", "PROCEDENCIA", "COD_CATEGORIA",
                         "P_MUE_DESEM", "COD_ESP_CAT", "SEXO", "PESO_MUESTRA", "MEDIDA",
                         "TALLA", "EJEM_MEDIDOS", "COD_PUERTO_DESCARGA")

  # select only samples from ICES
  records <- records[records$COD_PROYECTO==1101001,]

  # format fecha_muestreo
  records$FECHA <- as.POSIXlt(records$FECHA, format="%d/%m/%Y")


  # format columns as numeric:
    # create a function to format the numeric columns imported by default as character
    # TODO: allow a list of characters to apll in various columns
    format_numeric <- function (df, col){
      df[col] <- lapply(df[col], function(x){(sub("\\.", "", x))})
      df[col] <- lapply(df[col], function(x){(sub(",", "\\.", x))})
      df[col] <- as.numeric(df[[col]])
      return(df)
    }

    # format columns as numeric:
    records <- format_numeric(records, "P_DESEM")
    records <- format_numeric(records, "P_MUE_DESEM")
    records <- format_numeric(records, "PESO_MUESTRA")

  # convert code columns as factors:
    columns_factor <- c("COD_PUERTO", "COD_BARCO", "COD_ARTE",
    "COD_ORIGEN", "COD_PROYECTO", "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA",
    "COD_ESP_CAT", "COD_PUERTO_DESCARGA")

    #function to convert to factor in a row the columns
    # obj: list of characteres
    convert_factor <- function (obj){
      out <- lapply(obj, as.factor)
      as.data.frame(out)
    }

    # and convert it:
    records [, columns_factor] <- convert_factor(records [, columns_factor])

  # remove unused levels
  records <- droplevels(records)

  # return data
  if (by_month == FALSE){
    return(records)
  } else if (by_month >= 1 || by_month <= 12){
    return(subset(records, FECHA$mon == by_month-1))
  } else {
    return ("error in month selected")
  }
}
