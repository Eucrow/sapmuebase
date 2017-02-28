# ---- function to humanize dataframe ----------------------------------------
#
#' function to create new variables with description values from coded variables.
#'
#' Check if any of this variables exists in the dataframe:
#' - COD_PUERTO
#' - COD_BARCO
#' - COD_ARTE --> not available yet
#' - COD_ORIGEN --> not available yet
#' - COD_TIPO_MUE --> not available yet
#' - COD_ESP_MUE
#' - COD_CATEGORIA --> not available yet
#' - COD_ESP_CAT --> not available yet
#'
#' If it exists, create a new variable with its corresponding description values
#
#' @param df: dataframe to humanize
#' @return Return the original dataframe with description variables.
#' @import dplyr
#' @export
#'

humanize <- function(df){

  #check if package dplyr is instaled:
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("dplyr package needed for this function to work. Please install it.",
         call = FALSE)
  }


  if("COD_PUERTO" %in% colnames(df)){
    df <- merge(df, puerto, by.x = "COD_PUERTO", by.y = "COD_PUERTO", all.x = TRUE )
  }

  if("COD_BARCO" %in% colnames(df)){
    df <- merge(df, maestro_flota_sireno[,c("BARCOD", "BARDES")], by.x = "COD_BARCO", by.y = "BARCOD", all.x = TRUE )
  }

  especies <- maestro_categorias %>%
    select_("ESPCOD", "ESPDESTAX") %>%
    unique()

  if("COD_ESP_MUE" %in% colnames(df)){
    df <- merge(df, especies, by.x = "COD_ESP_MUE", by.y = "ESPCOD", all.x = TRUE )
  }

  #df <- df[,c(2,10,3,9,4,5,6,1,11,7,8)]

  return(df)

}
