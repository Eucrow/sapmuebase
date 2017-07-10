# ---- function to remove coma in the category "Chicharros, jureles" -----------
# return the dataframe corrected
remove_coma_in_category <- function(dataframe){
  dataframe[["CATEGORIA"]]<- gsub(",", "", dataframe[["CATEGORIA"]])
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
  dataframe[["YEAR"]] <- dataframe[["FECHA"]]$year+1900
  dataframe[["TRIMESTRE"]] <- quarters(dataframe[["FECHA"]])

  #remove 'Q' in quarter:
  dataframe[["TRIMESTRE"]] <- substring(dataframe[["TRIMESTRE"]], 2)
  dataframe[["FECHA"]] <- format(dataframe[["FECHA"]], "%d-%m-%y")

  #order columns
  dataframe <- dataframe %>%
    select(one_of(c("COD_ID", "FECHA", "DIA", "MES", "YEAR", "TRIMESTRE")), everything())

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
# This function check that the by_month variable is a numeric between 1 to 12
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

# ---- function to format the imported dataframe from muestreos up -------------
# Is called in the import functions of the tallas_x_up files.
# Change the format of the FECHA variable and remove the coma in the category
formatImportedFile <- function(df){
  # change the column "FECHA" to a date format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  df[["FECHA"]] <- change_date_format(df)

  df <- add_dates_variables(df)

  # and now the come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)


  # remove coma in the name of the categories
  df <- remove_coma_in_category(df)

  return(df)
}

# ---- function to import the 'tallas por up' files ----------------------------
#' Import 'muestreos tallas por up'
#'
#' This function import the three files obtained from 'muestreos tallas por up'
#' reports in SIRENO. The files are:
#' - des_tot: information with total landings
#' - des_tal: landings of the length samples
#' - tal: lengths
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' has been created.
#'
#' @param des_tot vector with the total landings filenames
#' @param des_tal vector with the landings of the lengths samples filenames
#' @param tal vector with the lengths samples filenames
#' @param by_month to filter only by one month. Numeric between 1 to 12 to select
#' one month or FALSE for all the year. FALSE by default.
#' @param path path of the files. The working directory by default.
#' @param export to export muestreos_up dataframe in csv file. False by default.
#' @return Return a list with 3 data frames
#' @export

importMuestreosUP <- function(des_tot, des_tal, tal, by_month = FALSE, export = FALSE, path = getwd()){

  # check des_tot, des_tal and tal has the same length
  if(length(des_tot) != length(des_tal) | length(des_tot) != length(tal)){
    stop(paste0("the variables", des_tot, ", ", des_tal, ", ", tal, "does not have the same length."))
  }

  # import files
  catches <- importCatches(des_tot, path)

  catches_in_lengths <- importCatchesInLengths(des_tal, path)

  lengths <- importLengths(tal, path)

  # group in a list
  muestreos_up<-list(catches_in_lengths=catches_in_lengths, lengths=lengths, catches=catches)

  muestreos_up <- lapply(muestreos_up, function(x){
    x <- add_dates_variables(x)
    x
  })

  # filter by month, only in case by_month == TRUE
  by_month <- check_by_month_argument(by_month)

  if (by_month != FALSE){
    muestreos_up <- lapply(muestreos_up, function(x){x <- filter_by_month(x, by_month); x})
  }

  if (isTRUE(export)){
    exportListToCsv(muestreos_up)
  }

  #return list
  return(muestreos_up)
}
