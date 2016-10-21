# ---- function to remove coma in the category "Chicharros, jureles" -----------
# return the dataframe corrected
remove_coma_in_category <- function(dataframe){
  dataframe$CATEGORIA<- gsub(",", "", dataframe$CATEGORIA)
  #assign('dataframe',dataframe,.GlobalEnv)#this doesn't work, and I dont know why
  return(dataframe)
}

# ---- function to change date format in all dataframes of muestreos_up list ---
change_date_format <- function (dataframe){
  dataframe$FECHA <- as.Date(dataframe$FECHA, "%d-%b-%y")
  dataframe$FECHA <- as.POSIXlt(dataframe$FECHA)
  dataframe$FECHA <- format(dataframe$FECHA, "%d-%m-%y")
}


# ---- function to filter by month all the dataframes of muestreos_up list -----
filter_by_month <- function (dataframe, month){
  # format the month:
  month <- sprintf("%02d", month)

  # filter:
  dataframe <- dataframe[format.Date(dataframe$FECHA, "%m") == month,]

  #return dataframe:
  return(dataframe)
}

# ---- function to import the 'tallas por up' files ----------------------------
#' Import 'muestreos tallas por up'
#'
#' This function import the three files obtained from 'muestreos tallas por up' reports in SIRENO.
#'
#' @param des_tot file with the total landings
#' @param des_tal file with the landings of the lengths samples
#' @param tal file with the lengths samples
#' @param by_month to filter only by one month. If false nothing is filtered. False by default.
#' @param export to export muestreos_up dataframe in csv file. False by default.
#' @return Return a list with 3 data frames
#' @export

import_muestreos_up <- function(des_tot, des_tal, tal, by_month = FALSE, export = FALSE, path = getwd()){
  # full paths for every file
  fullpath_des_tot <- paste(path, des_tot, sep="/")
  fullpath_des_tal <- paste(path, des_tal, sep="/")
  fullpath_tal <- paste(path, tal, sep="/")

  # import files to data.frame
  catches <- read.table(fullpath_des_tot, sep=";", header = TRUE)
  catches_in_lengths <- read.table(fullpath_des_tal, sep=";", header = TRUE)
  lengths <- read.table(fullpath_tal, sep=";", header = TRUE)

  # group in list
  muestreos_up<-list(catches_in_lengths=catches_in_lengths, lengths=lengths, catches=catches)

  # change the column "FECHA" to a date format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  # change the format with lapply
  # it's necesary the last x inside the function, to return de vale of x modified
  muestreos_up <- lapply(muestreos_up, function(x){x$FECHA <- change_date_format(x); x})

  # and now the come back to the initial configuration of locale:
  Sys.setlocale("LC_TIME", lct)

  # filter by month, only in case by_month == TRUE
  # TODO: validate by_month between 1 and 12
  if (by_month != FALSE){
    muestreos_up <- lapply(muestreos_up, function(x){x <- filter_by_month(x, by_month); x})
  }

  # remove coma in the name of the categories
  # I don't know why this doesn't work:
  # lapply(muestreos_up, function(x){x <- remove_coma_in_category(x)})
  # so I've to do this:
  muestreos_up$catches <- remove_coma_in_category(muestreos_up$catches)
  muestreos_up$catches_in_lengths <- remove_coma_in_category(muestreos_up$catches_in_lengths)
  muestreos_up$lengths <- remove_coma_in_category(muestreos_up$lengths)

  #return list
  return(muestreos_up)
}

