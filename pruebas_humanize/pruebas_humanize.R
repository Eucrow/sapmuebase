
#setwd(paste0(getwd(), "/pruebas_humanize"))



# ---- function to check variable format----------------------------------------
#
#' Function to check if a variable in a dataframe have correct format
#' Only available for "COD_PUERTO", "COD_BARCO", "COD_ARTE", "COD_ORIGEN",
#' "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA", "COD_ESP_CAT".
#'
#' The variable format is defined by regular expressions in dataset variables_format.
#'
#' @param df: dataframe with the format variable to check
#' @param var_to_check: variable to check
#' @return TRUE if the format is correct. Return list of errors if there are any mistake.
#' @export
#'
checkFormatVariable <- function(df, var_to_check){

  # check if var_to_check is a variable able to check format
  available_variables <- c("COD_PUERTO", "COD_BARCO", "COD_ARTE", "COD_ORIGEN",
                           "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA", "COD_ESP_CAT")

  if(!var_to_check %in% available_variables){
    stop( paste0(var_to_check, " is not an available variable to check."))
  }

  #import variables format file
  variables_format <- read.table(file = "variables_format.txt", row.names = NULL, header = TRUE, sep = ";", fill = TRUE, as.is = T)

  # check format
  format_regex <- variables_format[variables_format[["name_variable"]] == var_to_check, "regex_variable"]

  errors <- list()

  if (all(grepl(format_regex, df[[var_to_check]]))) {
    return(TRUE)
  } else {
    # stop ( paste0( var_to_check, " doesn't have the correct format") )
    errors[[var_to_check]] <- grep(format_regex, df[[var_to_check]], invert = TRUE)
    return(errors)
  }
}

# ---- function to check all the variables format--------------------------------
#
#' Function to check all the variables format
#' Search in dataframe the variables contained in variables_format.txt and check
#' its format
#'
checkAllFormatVariables <- function (df){

  to_check <- c("COD_PUERTO", "COD_BARCO", "COD_ARTE", "COD_ORIGEN", "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA", "COD_ESP_CAT")

  errors <- lapply(
      to_check,
      function(x){
        checkFormatVariable(df, x)
      })

  #remove true elements of the errors (because doesn't contain errors):
  errors <- errors[!errors %in% TRUE]

  return(errors)

}

l_port <- clean_lengths()

l_port$COD_BARCO <- "dñfajdñ"
l_port[1, "COD_BARCO"] <- "dfadfas"
l_port[14, "COD_ESP_CAT"] <- "33333333"
l_port[18, "COD_ESP_CAT"] <- "33333333"
l_port$COD_ESP_CAT <-"DFADF"
ppp <- checkAllFormatVariables(l_port)

checkFormatVariable(l_port, "COD_BARCO")


humanizePort <- function(df){
  if("COD_PUERTO" %in% colnames(df)){
    df <- merge(df, puerto[, c("COD_PUERTO", "PUERTO")], by.x = "COD_PUERTO", by.y = "COD_PUERTO", all.x = TRUE )
    return(df)
  } else {
    stop("Must be a variable called COD_PUERTO")
  }
}



humanize <- function(df){

  # list of the variables to humanize
  to_humanize <- c("COD_PUERTO", "COD_BARCO", "COD_ARTE", "COD_ORIGEN", "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA", "COD_ESP_CAT")

  # check if package dplyr is instaled:
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("dplyr package needed for this function to work. Please install it.",
         call = FALSE)
  } else {
    library(dplyr)
  }

  # check the format of the variables



  # save the colnames to maintain the order
  column_names <- colnames(df)

  df <- humanizePort(df)

  if("COD_BARCO" %in% colnames(df)){
    df <- merge(df, maestro_flota_sireno[,c("BARCOD", "BARDES")], by.x = "COD_BARCO", by.y = "BARCOD", all.x = TRUE )
  }

  especies <- maestro_categorias %>%
    select_("ESPCOD", "ESPDESTAX") %>%
    unique()

  if("COD_ESP_MUE" %in% colnames(df)){
    df <- merge(df, especies, by.x = "COD_ESP_MUE", by.y = "ESPCOD", all.x = TRUE )
  }

  # put new columns at the end of the dataframe
  df <- df %>%
    select(one_of(column_names), everything())

  return(df)

}

destal <- "IEOUPMUEDESTALSIRENO_2016_NEW5.TXT"

destot <- "IEOUPMUEDESTOTSIRENO_2016_NEW5.TXT"

tal <- "IEOUPMUETALSIRENO_2016_NEW5.TXT"

library(sapmuebase)



muestreos_up <- importMuestreosUP(destot, destal, tal)

catches <- muestreos_up$catches
lengths <- muestreos_up$lengths

clean_lengths <- function(){
  x <- lengths[1:500, c("FECHA", "COD_BARCO", "COD_PUERTO", "ESTRATEGIA", "METIER_DCF", "COD_ARTE", "COD_ORIGEN",
                   "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA", "COD_ESP_CAT")]
  return(x)
}

l_port <- clean_lengths()

l_port <- humanize(l_port)

