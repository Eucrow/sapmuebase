# sapmuebase

sapmuebase is a package with simple functions usefull in the SAP MUE team.

## Install
With `devtools` package installed:
```
library(devtools)
install_github("Eucrow/sapmuebase")
```

## Functions available (use `?nameofthefunction` to details):
#### importCsvSAPMUE()
Import csv files with special format usually used in SAPMUE team.
#### exportCsvSAPMUE()
Export csv files with special format usually used in SAPMUE team.
#### importMuestreosUP()
Import the 'muestreos tallas por up' files from SIRENO to R. 
#### importIPDFile()
Import the file with data to dump in SIRENO to R.
#### exportListToCsv()
Create a csv file for each dataframe in a list of dataframes.
#### separateDataframeByInfluenceArea()
This function separate a dataframe by influence area.
#### humanize() (work in progress)
Create new variables with description values from coded variables.
#### addInfluenceAreaVariable()
Add an influence area variable.

## Datasets available (use `?nameofthedataset` to details)
(Datasests name and its variables are in spanish)
#### areas_influecia
Influence areas in which are divided the sample zone.
#### arte
Gears
#### cfpo2015
#### cfpo2016
#### especies_mezcla
Mixed species
#### especies_no_mezcla
Non mixed species
#### estrato_rim
RIM stratum
#### estratorim_arte
Relation between Rim stratum and arte
#### maestros_categorias
Categories
#### maestro_flota_sireno
#### origen
Sampled origin
#### procedencia
Sampled source
#### puerto
Ports
#### tipo_mue
Type of sample
