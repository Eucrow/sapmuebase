# ---- function to import the IPD file -----------------------------------------
#' Import IPD file
#'
#' This function import the data of SAP MUE proyect from IPD file
#' @param filename name of the IPD file
#' @param by_month to filter only by one month. If false nothing is filtered. False by default.
#' @return Return a data frame.
#' @export

importIPDFile <- function(filename, by_month = FALSE){

  fullpath<-paste(getwd(), filename, sep="/")

  #read the file
  records <- read.fwf(
    file=fullpath,
    widths=c(10, 4, 6, 3, 3, 21, 10, 20, 1, 10, 8,  7, 7, 4, 20, 5, 20, 10, 4, 20, 5, 1, 20, 20, 10, 10, 10),
    strip.white = TRUE,
    dec = ","
  )

  colnames(records) <- c("FECHA", "COD_PUERTO", "COD_BARCO", "COD_ARTE",
                         "COD_ORIGEN", "ESTRATO_RIM", "COD_PROYECTO", "COD_TIPO_MUE",
                         "N_RECHAZOS", "N_BARCOS", "COD_CUADRICULA",
                         "LATITUD", "LONGITUD", "DIAS_MAR", "P_DESEM",
                         "COD_ESP_MUE", "TIPO_MUE", "PROCEDENCIA", "COD_CATEGORIA",
                         "P_MUE_DESEM", "COD_ESP_CAT", "SEXO", "peso_muestra", "medida",
                         "TALLA", "EJEM_MEDIDOS", "COD_PUERTO_DESCARGA")

  #select only samples from ICES
  records <- records[records$COD_PROYECTO==1101001,]

  #format fecha_muestreo
  records$FECHA <- as.POSIXlt(records$FECHA, format="%d/%m/%Y")


  #remove dots in numeric columns (dec = ",")
    #create a function to remove dots in columns
    #TODO: allow a list of characters to apll in various columns
    remove_dots <- function (df, col){
      sapply(df$col, function(x){(sub("\\.", "", x))})
      df
    }

  records <- remove_dots(records, "P_MUE_DESEM")
  records <- remove_dots(records, "P_MUE")


  #return data
  if (by_month == FALSE){
    return(records)
  } else if (by_month >= 1 || by_month <= 12){
    return(subset(records, FECHA$mon == by_month-1))
  } else {
    return ("error in month selected")
  }
}


