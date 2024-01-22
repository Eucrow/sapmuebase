# sapmuebase

v. 3.2.1

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

Import the SIRENO at-market reports from ICES project.

#### importRIMCatches()

Import SIRENO catches report from at-market sampling in the ICES project.

#### importRIMCatchesInLengths()

Import SIRENO catches in lengths report from at-market sampling in the ICES project.

#### importRIMLengths()

Import SIRENO lengths report from at-market sampling in the ICES project.

#### importOABFiles()

Import the SIRENO on board reports from ICES project.

#### importOABHauls()

Import SIRENO haul report from on-board sampling in the ICES project.

#### importOABHaulsCECAF()

Import SIRENO haul report from on-board sampling in the CECAF project.

#### importOABTrips()

Import SIRENO trips report from on-board sampling in the ICES project.

#### importOABTripsCECAF()

Import SIRENO trips report from on-board sampling in the CECAF project.

#### importOABCatches()

Import SIRENO catches report from on-board sampling in the ICES project.

#### importOABCatchesCECAF()

Import SIRENO catches report from on-board sampling in the CECAF project.

#### importOABLengths()

Import SIRENO lengths report from on-board sampling in the ICES project.

#### importOABLengthsCECAF()

Import SIRENO lengths report from on-board sampling in the CECAF project.

#### importOABLitter()

Import SIRENO litter report from on-board sampling in the ICES project.

#### importOABAccidentals()

Import SIRENO accidentals catches report from on-board sampling in the ICES project.

#### importIPDFile()

Import the file with data to dump in SIRENO to R.

#### exportListToCsv()

Create a csv file for each dataframe in a list of dataframes.

#### humanize()

Create new variables with description values from all the encoded variables in
a dataframe.

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

READ HELP BEFORE USE. Check the correct structure file of tallas_x_up SIRENO
reports.

#### fixReportSirenoFiles()

Use `?fixReportSirenoFiles` for details in R.

#### backupScripts()

Backup scripts and related files.

## Datasets available

Datasest names and its variables are mostly in spanish due to the language used
in SIRENO database.

The datasets with SIRENO data are only related to ICES area.

Use `?nameofthedataset` to details.

-   areas_influecia: influence areas in which are divided the sample zone.
-   arte: gears
-   especies: species dataset with different codes.
-   especies_mezcla: mixed species.
-   especies_prioritarias: priority of species in sampling.
-   especies_no_mezcla: non mixed species.
-   especies_prioritarias: priority species in sampling.
-   estrato rim: rim stratum.
-   estrato rim_arte: relation between rim stratum and gear.
-   estrato rim_origen: relation between rim stratum and origin.
-   categorias: categories species in SIRENO.
-   origen: sampled origin.
-   procedencia: sampled source.
-   puerto: ports.
-   tipo_muestreo: type of sample (previously called "tipo_mue").
-   formato_variables.
-   relacion_volcado.
-   variables_to_humanize: used in humanize() and humanizeVariable() functions.
-   rango_tallas_historico_caladero: dataset with minimun and maximun historical
    lengths by species and fishign ground.
-   metier_caladero_dcf: relation between metier, caladero_dcf, rim stratum and gear
-   metier_coherence: relation between metier, caladero_dcf, rim_stratum, origin and gear
-   p99_capturas_historico: list of species and its 99 percentile from 2014 to 2018 catches
-   caladero_origen: list of fishing ground with its origin used in SAP MUE team.
-   prescripciones_rim_mt2_2021_coherencia: coherence between the variables of
    MT2 samples 2021 RIM prescriptions.
-   prescripciones_oab_2021_coherencia: coherence between the variables of 2021 OAB
    prescriptions.
