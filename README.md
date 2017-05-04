# sapmuebase

sapmuebase is a package with simple functions usefull in the SAP MUE team.

## Install
With `devtools` package installed:
```
library(devtools)
install_github("Eucrow/sapmuebase")
```

## Functions available
Use `?nameofthefunction` to details.
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

## Datasets available
(Datasests name and its variables are in spanish)

Use `?nameofthedataset` to details.
* areas_influecia: influence areas in which are divided the sample zone.
* arte: gears
* cfpo2015
* cfpo2016
* especies_mezcla: mixed species
* especies_no_mezcla: non mixed species
* estrato_rim: _estrato rim_
* estratorim_arte: relation between _estrato rim_ and gear
* estratorim_origen: relation between _estrato rim_ and origin
* maestros_categorias: species categories
* maestro_flota_sireno
* origen: sampled origin
* procedencia: sampled source
* puerto: ports
* tipo_mue: type of sample

## Last changes:
### v. 1.3.5
- Add estratorim_origen dataset
### v. 1.3
- Modify importMuestreoUP:
   * to allow the new file format from SIRENO with COD_DIVISION and DIVISION variables
   * added "DIA", "MES", "AÑO" and "TRIMESTRE" variables in every returned dataframe
- Fix bugs in dataset especies_sexadas

