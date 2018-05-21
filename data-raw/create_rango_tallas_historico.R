library(devtools)
library(dplyr)
original_wd <- getwd()
setwd("data-raw/data_source_private")

file_data <- "IEOUPMUETALSIRENO_2014_2017.TXT"

data <- sapmuebase::importRIMLengths(file_data, getwd())

rg <- data %>%
  select(COD_ESP_CAT, SEXO, TALLA) %>%
  filter(!is.na(TALLA)) %>% # in some cases, there are lengths with NA
  group_by(COD_ESP_CAT, SEXO) %>%
  summarise(min_length = min(TALLA), max_length = max(TALLA))


colnames(rg) <- c("COD_ESP", "SEXO", "TALLA_MIN", "TALLA_MAX")

save(rg, file = "rango_tallas_historico.RData")
setwd(original_wd)
rm(original_wd, rg)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
