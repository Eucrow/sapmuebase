# This dataset is obtained from the file maestro_especies (wich is obtained
# from sireno as is) with this structure:
# * first 6 rows with useless information
# * the 7th row with this colnames:
#   COD.IEO, NOMBRE CIENTÍFICO, NOMBRE OFICIAL, AUTOR, ALFA3, TAXONÓMICO FAO, NODC, RUBIN
# Then, use the package worms to obtain the Aphia_ID code.

library(devtools)

# check if package worms is instaled:
if (!requireNamespace("worms", quietly = TRUE)) {
  stop("worms package needed for this function to work. Please install it.",
       call = FALSE)
} else {
  library(worms)
}

original_wd <- getwd()
setwd("data-raw")
especies <- read.csv("maestro_especies.csv",
                     sep=";",
                     skip = 6,
                     header = TRUE,
                     colClasses = c("factor"))
especies <- especies[, c("COD.IEO","NOMBRE.CIENTÍFICO","ALFA3")]
colnames(especies) <- c("COD_ESP", "ESP", "A3")

#import aphia_id code from Worms webservice
library(worms)
species_to_search <- as.character(especies$ESP)
species_codes <- wormsbynames(species_to_search, ids = FALSE, match = FALSE, verbose = TRUE,
                          chunksize = 50, like = "false", marine_only = "true",
                          sleep_btw_chunks_in_sec = 0.1)
species_codes_clean <- species_codes[,c("valid_AphiaID", "scientificname")]

#final dataset
especies <- merge(x=especies, y=species_codes_clean, by.x = "ESP", by.y = "scientificname", all.x = T)
colnames(especies) <- c("ESP", "COD_ESP", "A3", "APHIA_ID")
especies <- especies[,c("COD_ESP", "ESP", "A3", "APHIA_ID")]

# use_data() create the file in /data
usethis::use_data(especies, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, especies)
