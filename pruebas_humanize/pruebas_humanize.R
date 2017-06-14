
# old_wd <- getwd()
# setwd(paste0(getwd(), "/pruebas_humanize"))
# setwd(old_wd)

importMuestreosUPRECORTADA <- function(des_tot, des_tal, tal, by_month = FALSE, export = FALSE, path = getwd()){
  # full paths for every file
  fullpath_des_tot <- paste(path, des_tot, sep="/")
  fullpath_des_tal <- paste(path, des_tal, sep="/")
  fullpath_tal <- paste(path, tal, sep="/")

  # import files to data.frame
  catches <- tryCatch(
    read.table(fullpath_des_tot, sep=";", header = TRUE, quote = ""),
    error = function(err) {
      error_text <- paste("error in file", des_tot, ": ", err)
      stop(error_text)
    }
  )

  catches_in_lengths <- tryCatch(
    read.table(fullpath_des_tal, sep=";", header = TRUE, quote = ""),
    error = function(err) {
      error_text <- paste("error in file", des_tal, ": ", err)
      stop(error_text)
    }
  )

  lengths <- tryCatch(
    read.table(fullpath_tal, sep=";", header = TRUE, quote = ""),
    error = function(err) {
      error_text <- paste("error in file", tal, ": ", err)
      stop(error_text)
    }
  )

  # group in list
  muestreos_up<-list(catches_in_lengths=catches_in_lengths, lengths=lengths, catches=catches)

  return(muestreos_up)
}


humanizePort <- function(df){
  if("COD_PUERTO" %in% colnames(df)){
    df <- merge(df, puerto[, c("COD_PUERTO", "PUERTO")], by.x = "COD_PUERTO", by.y = "COD_PUERTO", all.x = TRUE )
    return(df)
  } else {
    stop("Must be a variable called COD_PUERTO")
  }
}

# humanizeVariable <- function(df, variable){
# }
  df <- catches
  variable <- "COD_ESP_MUE"

  #check if variable exists in the dataframe
  if(variable %in% colnames(df)){


    # variable_in_master <- variables_to_humanize %>%
    #   filter(ORIGINAL_VAR == variable) %>%
    #   select(MASTER_VAR)

    variable_data <- variables_to_humanize[variables_to_humanize[["ORIGINAL_VAR"]] %in% variable,]

    # check that there are just one record for the variable to humanize in variables_to_humanize dataset
    if (nrow(variable_data) != 1) {
      stop (paste("There is an error with the", variable, "variable in", df, "dataframe.
                  Check if the variable exists in variables_to_humanize dataset or if
                  there are various records for", variable, "."))
    }

    #
    # original_var = variable argument in the function, but is extracted here
    # from variable_data for a better understanding
    original_var <- as.character(variable_data[["ORIGINAL_VAR"]])
    master_var <- as.character(variable_data[["MASTER_VAR"]])
    humanized_var <- as.character(variable_data[["HUMANIZED_VAR"]])
    master <- as.character(variable_data[["MASTER"]])

    df <- merge(df, master[, c(master_var, humanized_var)], by.x = original_var, by.y = master_var, all.x = TRUE )

    return (df)
    # df <- merge(df, puerto[, c("COD_PUERTO", "PUERTO")], by.x = "COD_PUERTO", by.y = "COD_PUERTO", all.x = TRUE )
    # return(df)


  } else {
    stop("Does not exist this variable in dataframe")
  }



prueba <- humanizeVariable(catches, "COD_ESP_MUE")
as.character(prueba)

humanize <- function(df){

  # list of the variables to humanize
  to_humanize <- c("COD_PUERTO",
                   "COD_BARCO",
                   "COD_ARTE",
                   "COD_ORIGEN",
                   "COD_TIPO_MUE",
                   "COD_ESP_MUE",
                   "COD_CATEGORIA",
                   "COD_ESP_CAT")

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


clean_lengths <- function(){
  x <- lengths[1:500, c("FECHA", "COD_BARCO", "COD_PUERTO", "ESTRATEGIA", "METIER_DCF", "COD_ARTE", "COD_ORIGEN",
                        "COD_TIPO_MUE", "COD_ESP_MUE", "COD_CATEGORIA", "COD_ESP_CAT")]
  return(x)
}

library(sapmuebase)

destal <- "IEOUPMUEDESTALSIRENO_2016_NEW5.TXT"

destot <- "IEOUPMUEDESTOTSIRENO_2016_NEW5.TXT"

tal <- "IEOUPMUETALSIRENO_2016_NEW5.TXT"
muestreos_up <- importMuestreosUPRECORTADA(destot, destal, tal)
catches <- muestreos_up$catches
#
# muestreos_up <- importMuestreosUP(destot, destal, tal)
# catches <- muestreos_up$catches
# lengths <- muestreos_up$lengths

#muestreos_up <- readRDS("muestreosUP_2016_2014_20170509.rds")
lengths <- muestreos_up$lengths

#l_port <- clean_lengths()
l_port <- lengths

l_port[20:30,"COD_BARCO"] <- "dñfajdñ"
l_port[1, "COD_BARCO"] <- "dfadfas"
l_port[14, "COD_ESP_CAT"] <- "33333333"
l_port[18, "COD_ESP_CAT"] <- "33333333"

l_port[30:40, "PROCEDENCIA"] <- "IIM"

l_port_part <- l_port[1:500,]

ppp <- checkAllFormatVariables(l_port_part)
ppp

exportListToCsv(ppp)

l_port[48492,"COD_ID"]

checkFormatVariable(l_port, "COD_BARCO")
prueba <-  checkFormatVariable(lengths, "EJEM_MEDIDOS")

exportCsvSAPMUEBASE(lengths, "prueba_lengths.csv")


