# This data set is obtained from the file 'especies' (which is obtained
# from sireno as is) with this structure:
# * first 6 rows with useless information
# * the 7th row with this column names:
#   COD.IEO, NOMBRE CIENTÍFICO, NOMBRE OFICIAL, AUTOR, ALFA3, TAXONÓMICO FAO, NODC, RUBIN
# Then, use the package worms to obtain the Aphia_ID code.

library(devtools)

# check if package worms is installed:
if (!requireNamespace("worms", quietly = TRUE)) {
  stop("worms package needed for this function to work. Please install it.",
       call = FALSE)
} else {
  library(worms)
}

original_wd <- getwd()
setwd("data-raw")
especies <- read.csv("especies.csv",
                     sep=";",
                     skip = 6,
                     header = TRUE,
                     colClasses = c("factor"),
                     fileEncoding = "windows-1252")
especies <- especies[, c("COD.IEO","NOMBRE.CIENTÍFICO","ALFA3")]
colnames(especies) <- c("COD_ESP", "ESP", "A3")

#import aphia_id code from Worms api
library(worms)
especies$ESP <- as.character(especies$ESP)

# Rename some species
especies[especies$ESP=="Actinopterigios", "ESP"] <- "Actinopterygii"
# The next species has been fixed in SIRENO, so the next time this data set is
# created this will be unnecessary:
especies[especies$ESP=="Spirontocaris Iilljeborgi", "ESP"] <- "Spirontocaris lilljeborgi"


# Some species has a rare white space at the end which can't be removed with trimws()
# so it has to be done manually.
# This has been fixed in SIRENO, so the next time this data set is
# created this will be unnecessary:
especies[especies$COD_ESP=="40359", "ESP"] <- "Paelopatides grisea"
especies[especies$COD_ESP=="10110", "ESP"] <- "Tetronarce nobiliana"
especies[especies$COD_ESP=="40358", "ESP"] <- "Hymenaster agassizi"


species_to_search <- as.character(especies$ESP)
species_to_search <- trimws(species_to_search, which="right")
species_to_search <- trimws(species_to_search, which="right", whitespace =" spp")
# repeat the same trimws with '.spp' because there are any species with a rare character instead of whitespace
species_to_search <- trimws(species_to_search, which="right", whitespace =".spp")


species_codes <- wormsbynames(species_to_search, ids = FALSE, match = FALSE, verbose = TRUE,
                          chunksize = 100, like = "false", marine_only = "true",
                          sleep_btw_chunks_in_sec = 0.1)
species_codes_clean <- species_codes[,c("valid_AphiaID", "scientificname")]

#final dataset
especies$ESP_to_merge <- trimws(especies$ESP, which="right", whitespace =" spp")
especies <- merge(x=especies, y=species_codes_clean, by.x = "ESP_to_merge", by.y = "scientificname", all.x = T)
especies <- especies[,c("COD_ESP", "ESP", "A3", "valid_AphiaID")]
colnames(especies) <- c("COD_ESP", "ESP", "A3", "APHIA_ID")

# use_data() create the file in /data
usethis::use_data(especies, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, especies)
