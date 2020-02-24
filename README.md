# sapmuebase

sapmuebase is a package with functions useful in the SAP MUE team. Most of them
are related to the import of reports from IEO's SIRENO database in R, with a
common format.

**Note**: Various functions of sapmuebase package require the 'tallas por UP' 
reports or OAB reports from IEO's SIRENO database

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
(Datasests name and its variables are in spanish)

Use `?nameofthedataset` to details.
* areas_influecia: influence areas in which are divided the sample zone.
* arte: gears
* cfpo2018
* especies
* especies_mezcla: mixed species
* especies_no_mezcla: non mixed species
* estrato_rim: _estrato rim_
* estratorim_arte: relation between _estrato rim_ and gear
* estratorim_origen: relation between _estrato rim_ and origin
* maestro_categorias: species categories
* maestro_flota_sireno
* origen: sampled origin
* procedencia: sampled source
* puerto: ports
* tipo_mue: type of sample
* formato_variables
* relacion_volcado
* variables_to_humanize: used in humanize() and humanizeVariable() functions
* rango_tallas_historico: dataset with minimun and maximun historical lengths by species and sex
* metier_caladero_dcf: relation between metier, caladero_dcf, area and estrato_rim

## Last changes:
### 2.0.4
Update especies_no_mezcla and formato_variables datasets.
### 2.0.3
Update especies_mezcla and especies_no_mezcla datasets.
### 2.0.2
Change Inf and -Inf to NA in rango_tallas_historico dataset.
### 2.0.1
Fix and add new data to 'estratorim_arte', 'estratorim_origen' and 'origen' datasets.
Update rango_tallas_historico dataset with year 2018.
Update convertSNtoLogical() assuming empty values as FALSE values.
### 2.0
Improve import of logical variables in SIRENO reports.
Fix minor bugs in some date fields.
### 1.9.9
Fix minor bugs.
### 1.9.8
Add variable FECHA_LANCE when the hauls report is imported.
### 1.9.7
Standarize the format of date fields of all the datasets imported. Fix format of some OAB variables imported.
### 1.9.6
Add path argument to exportListToXlsx() function.
### 1.9.5
Create function fixReportSirenoFiles() function and use it in the importation functions of Sireno reports.
### 1.9.4
Create importOABLitter() and importOABAccidentals().
### 1.9.3
Fix bug in importIPDFile() function.
### 1.9.2
Add metier_caladero_dcf dataset and update estratorim_arte and
maestro_flota_sireno datasets. Remove old cfpo datasets.
### 1.9.1
Update and fix estratorim_arte, estratorim_origen and estrato_rim datasets.
### 1.9
Update some datasets with variables RIM and OAB to specify wich data is used in
RIM or OAB.
Delete older specified OAB datasets.
Add CFPO2018 dataset.
### 1.8.17
Update p97_capturas_historico dataset with years 2014 to 2017.
Update rango_tallas_historico dataset with years 2014 to 2017.
Remove rangeLengthsUP() function.
### 1.8.16
Add columns METIER_IEO importRIMfiles().
Update maestro_categorias dataset.
### 1.8.15
Add columns COD_MUESTREADOR and OBSERVACIONES to importRIMfiles().
### 1.8.14
Fix bugs in importIPDFiles() and exportCsvSAPMUEBASE().
### 1.8.13
Add columns COD_MUESTREADOR and OBSERVACIONES to importIPDFiles().
### 1.8.12
Fix error in P97 dataset.
### 1.8.11
Change the influence area of Finisterre in areas_influencia dataset.
### 1.8.10
Fix error in areas_influencia dataset.
### 1.8.9
Add p90_capturas_historico dataset.
### 1.8.8
Fixed bug in column names in formato_variables and relacion_variables dataset.
### 1.8.7
Fixed bug in importOABfiles() function.
### 1.8.6
Fixed this bugs:
    - add new variables to formato_variables dataset
    - add new variables to relacion_variables dateset
    - add notes to documentation from OAB import functions
### 1.8.5
- Add A3 FAO code and Aphia_Id Worms code to especies dataset
### 1.8.4
- Add new species to sexed species datasets
- Fix description fields in origen dataset
- Minor changes in documentation.
### 1.8.3
- Fix function humanize() and humanizeVariable()
- Create dataset relacion_volcado
- Improve dataset formato_variables
### 1.8.2
- Change the name of the variable 'AÑO' to 'YEAR'
- Fix minor changes in documentation.
- Adapt import RIM functions to the new variables "FECHA_MUE" and "FECHA_DESEM"
### 1.8
- Add functions to import OAB reports: importOABFiles(), importOABHauls(),
importOABTrips(), importOABCatches() and importOABLengths().
- Rename functions to import RIM reports.
### 1.7
- Add checkStructureFile() function.
- Add 'ESTRATEGIA' variable to 'tipo_mue' dataset.
### 1.6:
- Create sizeRangeUP() function.
- Crete rango_tallas_historico dataset.
### 1.5:
- Change variable "AÑO" to "YEAR" in dataframes returned by 'tallas por up' import functions.
- Improve importMuestreosUP() function:
  * Can import various 'tallas por up' files at the same time.
  * The variables now are well formatted in the import 'tallas por up' functions.
- Create importCatches(), importCatchesInLengths() and importLengths() functions.
### 1.4:
- Create formato_variables dataset.
- Create checkAllFormatVariables() function.
- Create checkFormatVariable() function.
- Create variables_to_humanize dataset.
- Create humanizeVariable() function.
- Improve humanize() function.
- Fix bug in importIPDFile() function in FECHA_DESEM format.
### v. 1.3.8
- Change date fields as POSIXct in importIPDFile.
- Add new type sample in tipo_mue dataset.
### v. 1.3.7
- Update importIPDFile() function according the new file format.
### v. 1.3.6
- Fix estratorim_origen dataset.
### v. 1.3.5
- Add estratorim_origen dataset.
### v. 1.3
- Modify importMuestreoUP:
   * to allow the new file format from SIRENO with COD_DIVISION and DIVISION variables
   * added "DIA", "MES", "AÑO" and "TRIMESTRE" variables in every returned dataframe
- Fix bugs in dataset especies_sexadas.
