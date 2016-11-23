# sapmuebase
v0.9

sapmuebase is a package with simple functions useful in the SAP MUE project

## Install
With `devtools` package installed:
```
library(devtools)
install_github("Eucrow/sapmuebase")
```

## Functions available:
### importMuestreosUp()
Import the 'muestreos tallas por up' files from SIRENO to R. 
### importIPDFile()
Import the file with data to dump in SIRENO to R.
### exportListToCsv()
Create a csv file for each dataframe in a list of dataframes.
### separateDataframeByInfluenceArea()
This function separate a dataframe by influence area.
### humanize()
Create new variables with description values from coded variables.
