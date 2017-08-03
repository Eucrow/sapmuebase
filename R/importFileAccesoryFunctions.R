# Function to import a file from SIRENO's reports. Valid with tallas_x_up files and
# discards files (exceptio with discard catches file, because it have a different
# separation character in some numeric fields)
importFileFromSireno <- function (x, file_type, path){

  tryCatch({
    fullpath <- file.path(path, x)
    struct <- getStructureFiles(fullpath, file_type)
    type <- struct[["class_variable_final"]]
    read.table(fullpath, sep = ";", header = TRUE, quote = "", colClasses = type)
  }, error = function(err) {
    error_text <- paste("error in file", x, ": ", err)
    stop(error_text)
  })

}

# ---- Function to get the first line with variable names of a file
readHeaderFiles <- function(file){

  header <- read.table(file, sep=";", header = TRUE, quote = "", dec = ",", nrows = 1)
  header <- colnames(header)
  header_df <- data.frame("original_name_variable" = header)
  #header <- readLines(fullpath, n = 1)
  # header <- unlist(strsplit(header, ";"))
  # header <- data.frame(original_name_variable = header)
  return(header_df)

}


# ---- Function to get the structure of the files stored in formato_variables dataset
# Gets the name_variable and class_variable_final variables
getStructureFiles <- function(file, file_type){

  header_file <- readHeaderFiles(file)
  struct <-
    formato_variables[
      !is.na(formato_variables[[file_type]]),
      c("original_name_variable", "name_variable", "class_variable_final", file_type)]
  struct[["original_name_variable"]] <- as.factor(struct[["original_name_variable"]])
  # Must use left_join instead of merge because it's imperative mantain the order of the columns:
  # struct_file <- left_join(header_file, struct, by = "original_name_variable")
  struct_file <- merge(x = header_file, y = struct, by = c("original_name_variable"))
  struct_file <- struct_file[order(struct_file[file_type]),]
  return(struct_file)

}

# ---- Function to change the variables name of the imported file to the new names
# stored in formato_variables dataset
renameFileVariables <- function(df, file_type) {

  new_colnames <-
    formato_variables[ !is.na(formato_variables[[file_type]]), c("name_variable", file_type) ]

  new_colnames <- new_colnames[order(new_colnames[[file_type]]),"name_variable"]

  colnames(df) <- new_colnames

  return(df)

}

# ---- function to remove coma in the category "Chicharros, jureles" -----------
# return the dataframe corrected
remove_coma_in_category <- function(dataframe){
  dataframe[["CATEGORIA"]]<- gsub(",", "", dataframe[["CATEGORIA"]])
  return(dataframe)
}

# ---- function to change date format in a dataframes --------------------------
change_date_format <- function (dataframe){
  dataframe[["FECHA"]] <- as.Date(dataframe[["FECHA"]], "%d-%b-%y")
  dataframe[["FECHA"]] <- as.POSIXlt(dataframe[["FECHA"]])
  dataframe[["FECHA"]] <- format(dataframe[["FECHA"]], "%d-%m-%y")
}

# ---- function to add 'AÑO', 'MES', 'DIA' and 'TRIMESTRE' ---------------------
# only usefull in RIM files (because contain de column FECHA)
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

# Remove the ' in the values of the CUADRICULA_ICES variable and convert to factor
# Only to use with aob files
fixCuadriculaICES <- function(df){

  if (!"CUADRICULA_ICES" %in% colnames(df)){
    stop("There aren't CUADRICULA_ICES variable in that dataframe")
  }

  df[["CUADRICULA_ICES"]] <- sub("'", "", df[["CUADRICULA_ICES"]])

  df[["CUADRICULA_ICES"]] <- as.factor(df[["CUADRICULA_ICES"]])

  return(df)

}
