# ---- function to remove coma in the category "Chicharros, jureles" -----------
# return the dataframe corrected
remove_coma_in_category <- function(dataframe){
  dataframe[["CATEGORIA"]]<- gsub(",", "", dataframe[["CATEGORIA"]])
  #assign('dataframe',dataframe,.GlobalEnv)#this doesn't work, and I dont know why
  return(dataframe)
}

# ---- function to change date format in all dataframes of muestreos_up list ---
change_date_format <- function (dataframe){
  dataframe[["FECHA"]] <- as.Date(dataframe[["FECHA"]], "%d-%b-%y")
  dataframe[["FECHA"]] <- as.POSIXlt(dataframe[["FECHA"]])
  dataframe[["FECHA"]] <- format(dataframe[["FECHA"]], "%d-%m-%y")
}

# ---- function to add 'AÑO', 'MES', 'DIA' and 'TRIMESTRE'
add_dates_variables <- function (dataframe){
  dataframe[["FECHA"]] <- as.POSIXlt(dataframe$FECHA, format="%d-%m-%y")
  dataframe[["DIA"]] <- dataframe[["FECHA"]]$mday
  dataframe[["MES"]] <- dataframe[["FECHA"]]$mon+1
  dataframe[["AÑO"]] <- dataframe[["FECHA"]]$year+1900
  dataframe[["TRIMESTRE"]] <- quarters(dataframe[["FECHA"]])
  #remove 'Q' in quarter:
  dataframe[["TRIMESTRE"]] <- substring(dataframe[["TRIMESTRE"]], 2)
  dataframe[["FECHA"]] <- format(dataframe[["FECHA"]], "%d-%m-%y")


  dataframe <- dataframe %>%
    select(COD_ID, FECHA, DIA, MES, AÑO, TRIMESTRE, everything())

  return(dataframe)
}

# ---- function to filter by month all the dataframes of muestreos_up list -----
filter_by_month <- function (dataframe, month){
  # format the month:
  month <- sprintf("%02d", month)

  # filter:
  dataframe <- dataframe[format.Date(dataframe[["FECHA"]], "%m") == month,]

  #return dataframe:
  return(dataframe)
}

# ---- function to check variable by_month -------------------------------------
# This function check that the by_by_month variable is a numeric between 1 to 12
# or FALSE
check_by_month_argument <- function(by_month) {
  tryCatch(
    {
      if (is.numeric(by_month)){
        if(by_month < 1 | by_month > 12) {
          #return ("error")
          error_text <- paste0("by_month = ", by_month, "??? How many by_months has your culture?")
          stop(error_text)
        } else {
          return(by_month)
        }
      } else if ( is.logical(by_month) & by_month == FALSE) {
        return(by_month)
      } else {
        #return ("error")
        stop(paste0("by_month has to be a numeric between 1 to 12 or FALSE to select all the year"))
      }
    },
    error = function(err) {
      error_text <- paste0("C'mon boy... ", err)
      message(error_text)
    }
  )
}


# ---- function to import the 'tallas por up' files ----------------------------
#' Import 'muestreos tallas por up'
#'
#' This function import the three files obtained from 'muestreos tallas por up' reports in SIRENO.
#'
#' @param des_tot file with the total landings
#' @param des_tal file with the landings of the lengths samples
#' @param tal file with the lengths samples
#' @param by_month to filter only by one month. Numeric between 1 to 12 to select
#' one month or FALSE for all the year. FALSE by default.
#' @param export to export muestreos_up dataframe in csv file. False by default.
#' @return Return a list with 3 data frames
#' @export

importMuestreosUP <- function(des_tot, des_tal, tal, by_month = FALSE, export = FALSE, path = getwd()){
  # full paths for every file
  fullpath_des_tot <- paste(path, des_tot, sep="/")
  fullpath_des_tal <- paste(path, des_tal, sep="/")
  fullpath_tal <- paste(path, tal, sep="/")

  # import files to data.frame
  catches <- tryCatch(
                  read.table(fullpath_des_tot, sep=";", header = TRUE, quote = "",
                             colClasses = c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,"character",
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)),
                  error = function(err) {
                    error_text <- paste("error in file", des_tot, ": ", err)
                    stop(error_text)
                  }
             )

  catches_in_lengths <- tryCatch(
                  read.table(fullpath_des_tal, sep=";", header = TRUE, quote = "",
                             colClasses = c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,"character",
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA)),
                  error = function(err) {
                    error_text <- paste("error in file", des_tal, ": ", err)
                    stop(error_text)
                  }
             )

  lengths <- tryCatch(
                  read.table(fullpath_tal, sep=";", header = TRUE, quote = "",
                             colClasses = c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,"character",
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                                            NA,NA,NA)),
                  error = function(err) {
                    error_text <- paste("error in file", tal, ": ", err)
                    stop(error_text)
                  }
             )


  # group in list
  muestreos_up<-list(catches_in_lengths=catches_in_lengths, lengths=lengths, catches=catches)

  # change the column "FECHA" to a date format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  # change the format with lapply
  # it's necesary the last x inside the function, to return the value of x modified
  muestreos_up <- lapply(muestreos_up, function(x){x[["FECHA"]] <- change_date_format(x); x})
  muestreos_up <- lapply(muestreos_up, function(x){x[["COD_ARTE"]] <- as.factor(x[["COD_ARTE"]]); x})
  muestreos_up <- lapply(muestreos_up, function(x){x[["COD_TIPO_MUE"]] <- as.factor(x[["COD_TIPO_MUE"]]); x})
  muestreos_up <- lapply(muestreos_up, function(x){x[["TALL.PESO"]] <- as.character(x[["TALL.PESO"]]); x})


  muestreos_up <- lapply(muestreos_up, function(x){
                                          x[["COD_ORIGEN"]] <- sprintf("%03d", x[["COD_ORIGEN"]])
                                          x[["COD_ORIGEN"]] <- as.factor(x[["COD_ORIGEN"]]);
                                          x})

  muestreos_up <- lapply(muestreos_up, function(x){
    x <- add_dates_variables(x)
    x
  })

  # and now the come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  # filter by month, only in case by_month == TRUE
  by_month <- check_by_month_argument(by_month)

  if (by_month != FALSE){
    muestreos_up <- lapply(muestreos_up, function(x){x <- filter_by_month(x, by_month); x})
  }

  # remove coma in the name of the categories
  # I don't know why this doesn't work:
  # lapply(muestreos_up, function(x){x <- remove_coma_in_category(x)})
  # so I've to do this:
  muestreos_up[["catches"]] <- remove_coma_in_category(muestreos_up[["catches"]])
  muestreos_up[["catches_in_lengths"]] <- remove_coma_in_category(muestreos_up[["catches_in_lengths"]])
  muestreos_up[["lengths"]] <- remove_coma_in_category(muestreos_up[["lengths"]])

  #convert COD_PUERTO to a character with 4 digits
  muestreos_up <- lapply(muestreos_up, function(x){
    x[["COD_PUERTO"]] <- sprintf("%04d", x[["COD_PUERTO"]])
    x
  })

  #return list
  return(muestreos_up)
}

