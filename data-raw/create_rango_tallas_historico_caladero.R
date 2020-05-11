library(devtools)
library(dplyr)
original_wd <- getwd()
setwd("data-raw")

# NOTE: the file rango_tallas_historico_caladero.csv has been created in
# /test_check_lengths/test_check_lengths.R Then, has been revised with Cooks
# distance graphs and corrected.
# 1. Create rango_tallas_historico_caladero ----

# fishing_ground <- read.table(file = "caladero.csv", head = TRUE, sep = ";",
#                              fill = TRUE, colClasses = c("character", "factor", "character"))
# rim_lengths_2014_2018 <- readRDS(file = "rim_lengths_2014_2018.rds")
# create_historical_range_fishing_ground <- function() {
#
#   fishing_ground <- fishing_ground[, c("CALADERO", "COD_ORIGEN")]
#   rim_lengths_2014_2018 <- merge(rim_lengths_2014_2018, fishing_ground, by = c("COD_ORIGEN"), all.x=T)
#
#   rango_tallas_historico_caladero <- rim_lengths_2014_2018 %>%
#     filter(PROCEDENCIA == "IEO") %>%
#     select(COD_ESP_CAT, CALADERO, SEXO, TALLA) %>%
#     group_by(COD_ESP_CAT, CALADERO, SEXO) %>%
#     summarise(min_length = min(TALLA, na.rm = T), max_length = max(TALLA, na.rm = T)) %>%
#     mutate(min_length = ifelse(is.infinite(min_length), NA, min_length)) %>%
#     mutate(max_length = ifelse(is.infinite(max_length), NA, max_length))
#
#   colnames(rango_tallas_historico_caladero) <- c("COD_ESP", "CALADERO", "SEXO", "TALLA_MIN", "TALLA_MAX")
#
#   return(rango_tallas_historico_caladero)
#
# }

# rango_tallas_historico_caladero <- create_historical_range_fishing_ground()

# The rango_tallas_historico_caladero must be revised with Cooks distance graphs
# and corrected. Then:
rango_tallas_historico_caladero <- sapmuebase::importCsvSAPMUE("rango_tallas_historico_caladero.csv")

rango_tallas_historico_caladero <- merge(rango_tallas_historico_caladero,
                                             especies[,c("ESP", "COD_ESP")], by.x = "ESPECIE", by.y = "ESP", all.x = T)

rango_tallas_historico_caladero <- rango_tallas_historico_caladero[, c("COD_ESP", "CALADERO", "t_min_final", "t_max_final")]

colnames(rango_tallas_historico_caladero) <- c("COD_ESP", "CALADERO", "TALLA_MIN", "TALLA_MAX")


# use_data() create the file in /data
usethis::use_data(rango_tallas_historico_caladero, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, rango_tallas_historico_caladero, file_data_2014_2017, file_data_2018,
   lengths_data_2014_2017, lengths_data_2018, lengths_data, formato_variables,
   relacion_variables)
