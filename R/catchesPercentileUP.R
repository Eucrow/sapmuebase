#' Create dataset with catches percentile for every species.
#'
#' This functions works with the catches files obtained by 'Tallas x up' reports
#' from SIRENO. It's possible user multiple files.
#'
#' The dataset obtained is used in 'revision volcado' script to check if the catches of
#' the species are in the range of previous years
#'
#' @param dfs vector of filenames with lengths. The file mus be obtained from
#' 'tallas x up' SIRENO reports.
#' @param path path where the files are located. Working directory by default.
#' @param per percentile to create (between 0 - 1)
#' @return dataframe with species, sex, minumum and maximun lengths

catchesPercentileUP <- function(dfs, path = getwd(), per){

  library(dplyr)

  data <- sapmuebase::importRIMCatches(dfs, path)

  percentile <- data %>%
    select(COD_ESP_MUE, ESTRATO_RIM, P_DESEM) %>%
    group_by(COD_ESP_MUE, ESTRATO_RIM) %>%
    summarise('90%' = quantile(P_DESEM, probs=per, na.rm = TRUE))

  return(percentile)

}





