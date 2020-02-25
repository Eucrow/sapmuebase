library(devtools)
library(dplyr)
original_wd <- getwd()
setwd("data-raw")


load("../data/relacion_variables.rda")
load("../data/formato_variables.rda")


file_data_2014_2017 <- "data_source_private/IEOUPMUETALSIRENO_2014_2017.TXT"
file_data_2018 <- "data_source_private/IEOUPMUETALSIRENO_2018.TXT"


lengths_data_2014_2017 <- sapmuebase::importRIMLengths(file_data_2014_2017, getwd())
lengths_data_2018 <- sapmuebase::importRIMLengths(file_data_2018, getwd())

lengths_data <- rbind(lengths_data_2014_2017, lengths_data_2018)

rango_tallas_historico_RIM <- lengths_data %>%
  filter(PROCEDENCIA == "IEO") %>%
  select(COD_ESP_CAT, SEXO, TALLA) %>%
  group_by(COD_ESP_CAT, SEXO) %>%
  summarise(min_length = min(TALLA, na.rm = T), max_length = max(TALLA, na.rm = T)) %>%
  mutate(min_length = ifelse(is.infinite(min_length), NA, min_length)) %>%
  mutate(max_length = ifelse(is.infinite(max_length), NA, max_length))

colnames(rango_tallas_historico_RIM) <- c("COD_ESP", "SEXO", "TALLA_MIN", "TALLA_MAX")

# use_data() create the file in /data
usethis::use_data(rango_tallas_historico_RIM, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, rango_tallas_historico_RIM, file_data_2014_2017, file_data_2018,
   lengths_data_2014_2017, lengths_data_2018, lengths_data)
