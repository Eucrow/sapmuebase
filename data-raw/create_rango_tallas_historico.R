library(devtools)
library(dplyr)
original_wd <- getwd()
setwd("data-raw")

file_data <- "data_source_private/IEOUPMUETALSIRENO_2014_2017.TXT"

load("relacion_variables.RData")
load("formato_variables.RData")

data <- sapmuebase::importRIMLengths(file_data, getwd())

rango_tallas_historico <- data %>%
  filter(PROCEDENCIA == "IEO") %>%
  select(COD_ESP_CAT, SEXO, TALLA) %>%
  filter(!is.na(TALLA)) %>% # in some cases, there are lengths with NA
  group_by(COD_ESP_CAT, SEXO) %>%
  summarise(min_length = min(TALLA), max_length = max(TALLA))


colnames(rango_tallas_historico) <- c("COD_ESP", "SEXO", "TALLA_MIN", "TALLA_MAX")

devtools::use_data(rango_tallas_historico, overwrite = TRUE)
devtools::use_data_raw()

save(rg, file = "rango_tallas_historico.RData") # ???
setwd(original_wd)
rm(original_wd, rg)

# IMPORTANT: COPY FILE TO /data???
# and then: devtools::use_data()
# and: document()

