library(devtools)
original_wd <- getwd()
setwd("data-raw")

catches <- c(
  # "IEOUPMUEDESTOTMARCO_2009.TXT",
  # "IEOUPMUEDESTOTMARCO_2010.TXT",
  # "IEOUPMUEDESTOTMARCO_2011.TXT",
  # "IEOUPMUEDESTOTMARCO_2012.TXT",
  # "IEOUPMUEDESTOTMARCO_2013.TXT",
  # "IEOUPMUEDESTOTMARCO_2014.TXT",
  # "IEOUPMUEDESTOTMARCO_2015.TXT",
  "IEOUPMUEDESTOTMARCO_2016.TXT")

load("relacion_variables.RData")
load("formato_variables.RData")

p90_capturas_historico <- sapmuebase::catchesPercentileUP(catches, path = "data_source_private")

colnames(p90_capturas_historico) <- c("COD_ESP", "ESTRATO_RIM", "P90")

save(p90_capturas_historico, file = "p90_capturas_historico.RData")
setwd(original_wd)
rm(original_wd, p90_capturas_historico)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
