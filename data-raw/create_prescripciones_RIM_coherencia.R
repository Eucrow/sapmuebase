#' Pescriptions coherence.
#'
#' A dataset containing the coherence between the variables of 2021 RIM
#' prescriptions. The original prescriptions document contain grouped variables
#' like fisheries with multiple rim stratum o grouped ports like "Avilés/Gijón".
#'
#' In this dataframe, those groups has been disagregated.
#'
#' And other variables has been added in order to get a complete dataset where
#' find the coherence between them allowed in prescriptpions.
#'
#' The dataset is created from prescripciones_rim_2021_coherencia.csv file.

library(devtools)

original_wd <- getwd()
setwd("data-raw")
prescripciones_rim_2021_coherencia <- read.csv("prescripciones_rim_2021_coherencia.csv",
                     sep=";",
                     header = TRUE,
                     colClasses = c("factor"))

# use_data() create the file in /data
usethis::use_data(prescripciones_rim_2021_coherencia, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, prescripciones_rim_2021_coherencia)
