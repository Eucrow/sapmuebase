# ---- function to create influence area variable ------------------------------
#
#' function to create a influence area variable from the COD_PUERTO variable
#'
#' Check if COD_PUERTO variable exists and create the AREA_INF variable.
#
#' @param df: dataframe to modify
#' @return Return the original dataframe with AREA_INF variable.
#' @export
#'

addInfluenceAreaVariable <- function(df, cod_puerto_column){

  if (is.data.frame(df)){

    data(areas_influencia)

    areas_influencia <- areas_influencia[,c("COD_PUERTO", "AREA_INF")]

    by_area <- merge(df, areas_influencia, by.x = cod_puerto_column, by.y = "COD_PUERTO", all.x = TRUE )

    return(by_area)

  } else {

    stop ("This doesn't like a dataframe")

  }

}
