library(devtools)
library(dplyr)
original_wd <- getwd()
setwd("data-raw")


load("../data/relacion_variables.rda")
load("../data/formato_variables.rda")

file_data <- "data_source_private/IEODESTALLASSIRENO_2014_2018_fixed.TXT"

lengths_data <- sapmuebase::importOABLengths(file_data, getwd())

rango_tallas_historico_OAB <- lengths_data %>%
  select(COD_ESP, SEXO, TALLA) %>%
  group_by(COD_ESP, SEXO) %>%
  summarise(min_length = min(TALLA, na.rm = T), max_length = max(TALLA, na.rm = T)) %>%
  mutate(min_length = ifelse(is.infinite(min_length), NA, min_length)) %>%
  mutate(max_length = ifelse(is.infinite(max_length), NA, max_length))

colnames(rango_tallas_historico_OAB) <- c("COD_ESP", "SEXO", "TALLA_MIN", "TALLA_MAX")

# use_data() create the file in /data
usethis::use_data(rango_tallas_historico_OAB, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, rango_tallas_historico_OAB, file_data, lengths_data,
   formato_variables, relacion_variables)
