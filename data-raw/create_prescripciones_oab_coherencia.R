#' Pescriptions coherence.
#'
#' A dataset containing the coherence between the variables of 2021 OAB
#' prescriptions. The original prescriptions document contain grouped variables
#' like ports ports like "Aguas Comunitarias no españolas".
#'
#' In this dataframe, those groups has been disagregated.
#'
#' And other variables has been added in order to get a complete dataset where
#' find the allowed coherence between them in prescriptpions.
#'
#' The dataset is created from prescripciones_oab_2021_coherencia.csv file.

library(devtools)

original_wd <- getwd()
setwd("data-raw")
prescripciones_oab_2021_coherencia <- read.csv("prescripciones_oab_2021_coherencia.csv",
                     sep=";",
                     header = TRUE,
                     colClasses = c("factor"), fileEncoding = "windows-1252")

# use_data() create the file in /data
usethis::use_data(prescripciones_oab_2021_coherencia, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, prescripciones_oab_2021_coherencia)
