# sapmuebase

sapmuebase is a package with simple functions usefull in the SAP MUE project

## Functions:
### import_muestreos_up()
Import the 'muestreos tallas por up' files from SIRENO.

### Use:
'''
foo <- import_muestreso_up(des_tot, des_tal, tal, by_month = FALSE, export = FALSE)
'''

### Params:
* des_tot: filename of the total landings file
* des_tal: filename of the landings of the lengths samples file
* tal: filename of the lengths samples file
* by_month: to select only one month. MONTH must be fill in the constants section. False by default.
* export: to export muestreos_up dataframe in csv file. False by default.

### Return
Return a list with 3 data frames