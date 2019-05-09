library(devtools)
library(dplyr)
original_wd <- getwd()
setwd("data-raw")

file_data <- "data_source_private/IEOUPMUETALSIRENO_2014_2017.TXT"

load("relacion_variables.RData")
load("formato_variables.RData")

lengths_data <- sapmuebase::importRIMLengths(file_data, getwd())

rango_tallas_historico <- lengths_data %>%
  filter(PROCEDENCIA == "IEO") %>%
  select(COD_ESP_CAT, SEXO, TALLA) %>%
  group_by(COD_ESP_CAT, SEXO) %>%
  summarise(min_length = min(TALLA, na.rm = T), max_length = max(TALLA, na.rm = T))

colnames(rango_tallas_historico) <- c("COD_ESP", "SEXO", "TALLA_MIN", "TALLA_MAX")

# use_data() create the file in /data
usethis::use_data(rango_tallas_historico, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, rango_tallas_historico)
