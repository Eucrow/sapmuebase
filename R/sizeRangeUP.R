#' Create dataset with maximun and minimun lengths for every species.
#'
#' This functions works with the lenght files obtained by 'Tallas x up' reports
#' from SIRENO. It's possible user multiple files
#'
#' The dataset obtained is used in 'revision volcado' script to check if the lengths of
#' the species are in the range of previous years
#'
#' @param dfs vector of filenames with lengths. The file mus be obtained from
#' 'tallas x up' SIRENO reports.
#' @param path path where the files are located. Working directory by default.
#' @return dataframe with species, sex, minumum and maximun lengths
#' @export

sizeRangeUP <- function(dfs, path = getwd()){

  library(dplyr)

  data <- sapmuebase::importLengths(dfs, path)

  maxmin <- data %>%
    select(COD_ESP_CAT, SEXO, TALLA) %>%
    filter(!is.na(TALLA)) %>% # in some cases, there are lengths with NA
    group_by(COD_ESP_CAT, SEXO) %>%
    summarise(min_length = min(TALLA), max_length = max(TALLA))

  return(maxmin)

}
