# Function to import a file from SIRENO's reports. Valid with RIM and oab
# files (exception with discard catches file, because it have a different
# separation character in some numeric fields). Apply format saved in
# formato_variables dataset.
importFileFromSireno <- function (x, file_type, path){

  tryCatch({

    fullpath <- file.path(path, x)

    # struct <- getStructureFiles(fullpath, file_type, "class_variable_import")

    struct <- getVariableTypes(file_type, "class_variable_import")

    type <- struct[["class_variable_import"]]

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


#' ---- Function to get the structure of the files stored in formato_variables dataset
#' There are two fields related to the type of variables: class_variable_import
#' and class_variable_final.
#' The import of the files require the use of the class variables contained in
#' class_variable_import. Then, some adjustments to certaing variables are made
#' (replace commas with dots in numeric fiedls...). And finally, the format of the
#' variables is changed with the class contained in class_variable_final.
#' @param file
#' @param file_type type of the file to import: "RIM_CATCHES",
#' "RIM_CATCHES_IN_LENGTHS", "RIM_LENGTHS", "OAB_TRIPS", "OAB_HAULS",
#' "OAB_CATCHES" or "OAB_LENGTHS"
#' @param status "class_variable_import" to get the classes of the variables in
#' the import proccess of a file; or "class_variable_final" to get final classes
#' which the variables must have.
getStructureFiles <- function(file, file_type, status_class){

  if(status_class != "class_variable_import" & status_class != "class_variable_final"){
    stop("'status_class' variable must be 'class_variable_import' or 'class_variable_final'")
  }

  header_file <- sapmuebase:::readHeaderFiles(file)

  name_variables <- merge(x = header_file, y = relacion_variables, by.x = c("original_name_variable"), by.y = c("original_name_variable"))

  #get only the variables for the file_type
  struct <-
    formato_variables[
      !is.na(formato_variables[[file_type]]),
      c("name_variable", status_class, file_type)]

  # Must use left_join instead of merge because it's imperative mantain the order of the columns:
  # struct_file <- left_join(header_file, struct, by = "original_name_variable")
  struct_file <- merge(x = name_variables, y = struct, by = c("name_variable"), all.x = T)
  struct_file <- struct_file[order(struct_file[file_type]),]
  return(struct_file)

}

#' Get the variable types of the RIM and OAB files downloaded from SIRENO.
#' This function use the formato_variables dataset.
#' Used in the import and format of the files.
#' @param file_type type of the file: "RIM_CATCHES",
#' "RIM_CATCHES_IN_LENGTHS", "RIM_LENGTHS", "OAB_TRIPS", "OAB_HAULS",
#' "OAB_CATCHES" or "OAB_LENGTHS"
#' @param status_class "class_variable_import" to get the classes of the variables in
#' the import proccess of a file; or "class_variable_final" to get final classes
#' which the variables must have.
#' @return dataframe with the name of the variable, status class and file type.
getVariableTypes <- function(file_type, status_class){

  if(status_class != "class_variable_import" & status_class != "class_variable_final"){
    stop("'status_class' variable must be 'class_variable_import' or 'class_variable_final'")
  }

  #get only the variables for the file_type
  struct <-
    formato_variables[
      !is.na(formato_variables[[file_type]]),
      c("name_variable", status_class, file_type)]

  struct <- struct[order(struct[[file_type]]),]

  return(struct)

}

#' Format the variables of a dataframe obtained by the RIM and OAB import
#' funcionts from this package.
#' The variable types are stored in formato_variables dataset.
#' @param df dataframe to format.
#' @param file_type type of the file: "RIM_CATCHES",
#' "RIM_CATCHES_IN_LENGTHS", "RIM_LENGTHS", "OAB_TRIPS", "OAB_HAULS",
#' "OAB_CATCHES" or "OAB_LENGTHS"
formatVariableTypes <- function(df, file_type){

  name_of_columns <- names(df)

  struct <- getVariableTypes(file_type, "class_variable_final")

  df <- lapply(seq_along(df), function(x, variables_name, type_variables){

    var_name <- variables_name

    new_var_type <- type_variables[type_variables[["name_variable"]] == var_name[x], "class_variable_final"]

    # Attention: df[x] is a list... but I don't know why...
    df[[x]] <- get(paste0("as.",new_var_type))(df[[x]])

    # tryCatch(
    #
    #   # Attention: df[x] is a list... but I don't know why...
    #   df[[x]] <- get(paste0("as.",new_var_type))(df[[x]]),
    #
    #   warning = function(w) {
    #     simpleWarning(paste0("Warning in variable ", var_name[x], " trying
    #                          convert to ", new_var_type, ". "))
    #   },
    #
    #   error = function(e){
    #     simpleError(paste0("Can't convert variable ", var_name[x], " in ",
    #                        new_var_type, ". "))
    #   }
    #
    # )

  }, names(df), struct)

  df <- as.data.frame(df, col.names = name_of_columns)

  return(df)

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

# ---- function to change coma with a dot in a variable form a dataframe -------
# return the dataframe corrected
replace_coma_with_dot <- function(dataframe, variable){
  dataframe[[variable]]<- gsub(",", ".", dataframe[[variable]])
  return(dataframe)
}

# ---- function to change date format in a dataframes --------------------------
change_date_format <- function (dataframe){
  dataframe[["FECHA_MUE"]] <- as.Date(dataframe[["FECHA_MUE"]], "%d-%b-%y")
  dataframe[["FECHA_MUE"]] <- as.POSIXlt(dataframe[["FECHA_MUE"]])
  dataframe[["FECHA_MUE"]] <- format(dataframe[["FECHA_MUE"]], "%d-%m-%y")
}

# ---- function to add 'AÑO', 'MES', 'DIA' and 'TRIMESTRE' ---------------------
# only usefull in RIM files (because contain the column FECHA_MUE)
add_dates_variables <- function (dataframe){
  dataframe[["FECHA_MUE"]] <- as.POSIXlt(dataframe$FECHA_MUE, format="%d-%m-%y")
  dataframe[["DIA"]] <- dataframe[["FECHA_MUE"]]$mday
  dataframe[["MES"]] <- dataframe[["FECHA_MUE"]]$mon+1
  dataframe[["YEAR"]] <- dataframe[["FECHA_MUE"]]$year+1900
  dataframe[["TRIMESTRE"]] <- quarters(dataframe[["FECHA_MUE"]])

  #remove 'Q' in quarter:
  dataframe[["TRIMESTRE"]] <- substring(dataframe[["TRIMESTRE"]], 2)
  dataframe[["FECHA_MUE"]] <- format(dataframe[["FECHA_MUE"]], "%d-%m-%y")

  #order columns
  dataframe <- dataframe %>%
    select(one_of(c("COD_ID", "FECHA_MUE", "DIA", "MES", "YEAR", "TRIMESTRE")), everything())

  return(dataframe)
}

# ---- function to filter by month all the dataframes of muestreos_up list -----
filter_by_month <- function (dataframe, month){
  # format the month:
  month <- sprintf("%02d", month)

  # filter:
  dataframe <- dataframe[format.Date(dataframe[["FECHA_MUE"]], "%m") == month,]

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
          error_text <- paste0("by_month = ", by_month, "??? How many by_months has your culture?")
          stop(error_text)
        } else {
          return(TRUE)
        }
      } else if ( is.logical(by_month) & by_month == FALSE) {
        return(TRUE)
      } else {
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
# Change the format of the FECHA_MUE variable and remove the coma in certain
# category names. In adition create date variables (DAY, MONTH, QUARTER...).
#' To allow an easiest use of this data in R, variables 'DIA', 'MES', 'YEAR' and
#' 'TRIMESTRE' are added.
formatImportedFile <- function(df){
  # change the column "FECHA_MUE" to a date format
  # to avoid some problems with Spanish_Spain.1252 (or if you are using another
  # locale), change locale to Spanish_United States.1252:
  lct <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME","Spanish_United States.1252")

  df[["FECHA_MUE"]] <- change_date_format(df)

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
