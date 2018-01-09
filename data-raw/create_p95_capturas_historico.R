library(devtools)
original_wd <- getwd()
setwd("data-raw")

catches <- c(
  "IEOUPMUEDESTOTSIRENO_2009_2015.TXT",
  "IEOUPMUEDESTOTMARCO_2016.TXT")

load("relacion_variables.RData")
load("formato_variables.RData")

p95_capturas_historico <- sapmuebase::catchesPercentileUP(catches, path = paste0(getwd(),"/data_source_private"), per = 0.95)

colnames(p95_capturas_historico) <- c("COD_ESP", "ESTRATO_RIM", "P95")

save(p95_capturas_historico, file = "p95_capturas_historico.RData")
setwd(original_wd)
rm(original_wd, p95_capturas_historico)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
