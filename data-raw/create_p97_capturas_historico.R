library(devtools)
original_wd <- getwd()
setwd("data-raw")

catches <- c(
  "IEOUPMUEDESTOTSIRENO_2009_2015.TXT",
  "IEOUPMUEDESTOTMARCO_2016.TXT")

load("relacion_variables.RData")
load("formato_variables.RData")

# I don't know why but I've to load the function catchesPercentileUP here
# in order to work the scritp... ¿?¿?¿?
catchesPercentileUP <- function(dfs, path = getwd(), per){

  library(dplyr)

  data <- sapmuebase::importRIMCatches(dfs, path)

  percentile <- data %>%
    select(COD_ESP_MUE, ESTRATO_RIM, P_DESEM) %>%
    group_by(COD_ESP_MUE, ESTRATO_RIM) %>%
    summarise('97%' = quantile(P_DESEM, probs=per, na.rm = TRUE))

  return(percentile)

}

p97_capturas_historico <- catchesPercentileUP(catches, path = paste0(getwd(),"/data_source_private"), per = 0.97)

colnames(p97_capturas_historico) <- c("COD_ESP", "ESTRATO_RIM", "P97")

save(p97_capturas_historico, file = "p97_capturas_historico.RData")
setwd(original_wd)
rm(original_wd, p97_capturas_historico)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
