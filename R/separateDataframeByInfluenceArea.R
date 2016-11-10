#' Separate a dataframe by influence area
#'
#' This function separate any dataframe by influence area according to a sireno
#' port variable available in the dataframe.
#'
#'
#'
#' @param df is the dataframe to split. It's imperative that contain a variable
#' with a sireno port code.
#' @return a list of dataframes for each influence area in the dataframe to
#' separate.
#' @export
#'
#'
separateDataframeByInfluenceArea <- function (df, cod_puerto_column){

  if (is.data.frame(df)){
    data(areas_influencia)

    areas_influencia <- areas_influencia[,c("COD_PUERTO", "AREA")]

    by_area <- merge(df, areas_influencia, by.x = cod_puerto_column, by.y = "COD_PUERTO", all.x = TRUE )
    by_area <- dlply (by_area, "AREA")

    return(by_area)

  } else {

    stop ("This doesn't like a dataframe")
  }

}
