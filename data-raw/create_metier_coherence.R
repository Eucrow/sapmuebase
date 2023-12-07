library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

# this data frame is the combination of metier_caladero_dcf and estrato_rim_arte
# datasets:
# metier_coherence <- merge(metier_caladero_dcf, estrato_rim_arte, all.x = TRUE)
# metier_coherence <- humanize(metier_coherence)
# metier_coherence <- metier_coherence[!is.na(metier_coherence$ARTE), ]
# metier_coherence <- metier_coherence[!is.na(metier_coherence$ORIGEN), ]
# metier_coherence <- metier_coherence[, c("METIER_DCF", "CALADERO_DCF", "ESTRATO_RIM", "COD_ORIGEN", "ORIGEN", "COD_ARTE", "ARTE")]
# metier_coherence <- metier_coherence[order(metier_coherence[,"METIER_DCF"], metier_coherence[,"ESTRATO_RIM"], metier_coherence[,"COD_ORIGEN"], metier_coherence[,"COD_ARTE"]), ]
# exportCsvSAPMUEBASE(metier_coherence, "metier_coherence.csv")

metier_coherence <- read.csv("metier_coherence.csv",
                                header = T,
                                colClasses ="factor",
                                sep = ";", fileEncoding = "UTF-8")

usethis::use_data(metier_coherence, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, metier_coherence)
