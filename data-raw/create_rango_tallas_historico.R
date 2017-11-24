library(devtools)
original_wd <- getwd()
setwd("data-raw")

data <- c("IEOUPMUETALMARCO_2009.TXT",
            "IEOUPMUETALMARCO_2010.TXT",
            "IEOUPMUETALMARCO_2011.TXT",
            "IEOUPMUETALMARCO_2012.TXT",
            "IEOUPMUETALMARCO_2013.TXT",
            "IEOUPMUETALMARCO_2014.TXT",
            "IEOUPMUETALMARCO_2015.TXT",
            "IEOUPMUETALMARCO_2016.TXT")

rango_tallas_historico <- sapmuebase::lengthsRangeUP(data, path = "data_source_private")

colnames(rango_tallas_historico) <- c("COD_ESP", "SEXO", "TALLA_MIN", "TALLA_MAX")

save(rango_tallas_historico, file = "rango_tallas_historico.RData")
setwd(original_wd)
rm(original_wd, rango_tallas_historico)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
