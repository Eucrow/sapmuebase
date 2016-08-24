# sapmuebase

sapmuebase is a package with simple functions usefull in the SAP MUE project

## Install
With `devtools` package installed:
```
library(devtools)
install_github("Eucrow/sapmuebase")
```

## Functions available:
### import_muestreos_up()
Import the 'muestreos tallas por up' files from SIRENO. Convert the code variables to factors.

### Use:
```
foo <- import_muestreso_up(des_tot, des_tal, tal, by_month = FALSE, export = FALSE)
```

### Params:
* `des_tot` filename of the total landings file
* `des_tal` filename of the landigs with lengths sampled file
* `tal` filename of the lengths samples file
* `by_month` to select only one month. MONTH must be fill in the constants section. False by default.
* `export` to export muestreos_up dataframe in csv file. False by default.

### Return:
Return a list with 3 data frames

### import_IPD_file()
Import the file with data to dump in SIRENO.

### Use:
```
foo <- import_IPD_file(filename, by_month = FALSE)
```

### Params:
* `filename` filename of the total landings file
* `by_month` to select only one month. MONTH must be fill in the constants section. False by default.

### Return:
Return a data frame called 'records'