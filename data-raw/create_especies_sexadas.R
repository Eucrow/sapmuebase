library(devtools)
original_wd <- getwd()
setwd("data-raw")
especies_sexadas <- read.csv("especies_sexadas.csv", colClasses = c("factor"), encoding = "UTF-8")

# use_data() create the file in /data (before, we had to copy manually, but not
# rigth now). The file created has extension .rda, instead of .Rdata.
usethis::use_data(especies_sexadas, overwrite = TRUE)

# we have to make sure there aren't a .Rdata file with the same name than the
# .rda file just created, because R read firts the .Rdata and ignore the .rda

devtools::document()

setwd(original_wd)
rm(original_wd, especies_sexadas)
