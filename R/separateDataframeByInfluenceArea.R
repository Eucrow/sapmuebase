#' Separate a dataframe by influence area
#'
#' This function separate any dataframe by influence area according to a sireno
#' port variable available in the dataframe.
#'
#'
#'
#' @param df is the dataframe to split. It's imperative that contain a variable
#' with a sireno port code or with a locode port code.
#' @param cod_port_column is the variable with the port code. It can be a SIRENO
#' port code (4 digits) or a LOCODE (5 uppercase character) code.
#' @return a list of dataframes for each influence area in the dataframe to
#' separate.
#' @export
#'
#'
separateDataframeByInfluenceArea <- function (df, cod_port_column){

  #check the correction of the dataframe
  if (!is.data.frame(df)){
    stop ("This doesn't like a dataframe")
  }

  type_code <- ""

  #check the correction of the cod_port_column
  if (all(grepl("^[A-Z]{5}$", df[[cod_port_column]])) ) {
    type_code <- "LOCODE"
  } else if (all(grepl("^\\d{4}$", df[[cod_port_column]]))) {
    type_code <- "COD_PUERTO"
  } else {
    stop ("LOCODE dosn't looks like a SIRENO code port or LOCODE. If code
          port column is a SIRENO code, it must be 4 digits. If it is a LOCODE
          port column, it must have five uppercase characters")
  }

  data(areas_influencia)

  areas_influencia <- areas_influencia[,c(type_code, "AREA_INF")]

  by_area <- merge(df, areas_influencia, by.x = type_code, by.y = type_code, all.x = TRUE )
  by_area <- dlply (by_area, "AREA_INF")

  return(by_area)

}
