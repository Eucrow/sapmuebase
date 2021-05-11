# sapmuebase

sapmuebase is a package with functions useful in the SAP MUE team. Most of them
are related to the import of reports from IEO's SIRENO database in R, with a
common format.

**Note**: Various functions of sapmuebase package require the 'tallas por UP' 
reports or OAB reports from IEO's SIRENO database.

## Install
With `devtools` package installed:
```
library(devtools)
install_github("Eucrow/sapmuebase")
```

## Functions available
Use `?nameofthefunction` to details.
#### speciesBelongToTaxon()
Check in WORMS if species belongs to a taxon.
#### importCsvSAPMUE()
Import csv files with special format usually used in SAPMUE team.
#### exportCsvSAPMUE()
Export csv files with special format usually used in SAPMUE team.
#### importRIMFiles()
Import the 'muestreos tallas por up' files from SIRENO to R.
#### importRIMCatches()
Import the 'Catches' file from 'tallas por up' report to R.
#### importRIMCatchesInLengths()
Import the 'Catches in Lengths' file from 'tallas por up' report to R.
#### importRIMLengths()
Import the 'Lengths' file from 'tallas por up' report to R.
#### importOABFiles()
Import the four OAB reports from SIRENO.
#### importOABHauls()
Import the Hauls file from OAB report.
#### importOABTrips()
Import the Trips file from OAB report.
#### importOABCatches()
Import the Catches file from OAB report.
#### importOABLengths()
Import the Lengths file from OAB report.
#### importOABLitter()
Import the Litter file from OAB report.
#### importOABAccidentals()
Import the Accidentals file from OAB report.
#### importIPDFile()
Import the file with data to dump in SIRENO to R.
#### exportListToCsv()
Create a csv file for each dataframe in a list of dataframes.
#### humanize()
Create new variables with description values from all the encoded variables in a dataframe.
#### humanizeVariable()
Create new variable with description values from one encoded variable.
#### checkAllFormatVariables()
Check all the variables format of a dataframe.
#### checkFormatVariable()
Check the correct format of a variable of a dataframe.
#### addInfluenceAreaVariable()
Add an influence area variable.
#### separateDataframeByInfluenceArea()
Separate a dataframe by influence area (only RIM influence area).
#### checkStructureFile()
READ HELP BEFORE USE. Check the correct structure file of tallas_x_up SIRENO reports. 
#### fixReportSirenoFiles()
use `?fixReportSirenoFiles` for details in R.

## Datasets available
Datasest names and its variables are mostly in spanish due to the language used
in SIRENO database.

The datasets with SIRENO data are only related to ICES area.

Use `?nameofthedataset` to details.
* areas_influecia: influence areas in which are divided the sample zone.
* arte: gears
* especies
* especies_mezcla: mixed species
* especies_no_mezcla: non mixed species
* estrato_rim: _estrato rim_
* estrato_rim_arte: relation between _estrato rim_ and gear (previously called "estratorim_arte")
* estrato_rim_origen: relation between _estrato rim_ and origin (previously called "estratorim_origen")
* categorias: categories species in SIRENO 
* maestro_flota_sireno
* origen: sampled origin
* procedencia: sampled source
* puerto: ports
* tipo_muestreo: type of sample (previously called "tipo_mue")
* formato_variables
* relacion_volcado
* variables_to_humanize: used in humanize() and humanizeVariable() functions
* rango_tallas_historico_caladero: dataset with minimun and maximun historical
lengths by species and fishign ground.
* metier_caladero_dcf: relation between metier, caladero_dcf, area and estrato_rim
* p99_capturas_historico: list of species and its 99 percentile from 2014 to 2018 catches
* caladero_origen: list of fishing ground with its origin used in SAP MUE team.
* prescripciones_rim_2021_coherence: coherence between the variables of 2021 RIM
prescriptions.

