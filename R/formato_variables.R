#' Variables format
#'
#' A dataset containing the format of the variables and its obligatory in the
#' tallas_x_up and oab reports from SIRENO.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{name_variable}{name of the variable}
#'   \item{regex_variable_import}{regular expression of the variable in the import process}
#'   \item{class_variable_import}{class of the variable in the import process}
#'   \item{regex_variable_final}{regular expression that should be the variable after import process}
#'   \item{class_variable_final}{class that should be the variable after import process}
#'   \item{RIM_CATCHES}{order of the field in RIM catches file. NA if the field doesn't exist in the file}
#'   \item{RIM_CATCHES_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{RIM_CATCHES_IN_LENGTHS}{order of the field in RIM in catches_in_lengths file. NA if the field doesn't exist in the file}
#'   \item{RIM_LENGTHS}{order of the field in RIM lengths file. NA if the field doesn't exist in the file}
#'   \item{RIM_LENGTHS_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{AOB_TRIPS}{order of the field in OAB trips file. NA if the field doesn't exist in the file}
#'   \item{AOB_TRIPS_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{AOB_HAULS}{order of the field in OAB hauls file. NA if the field doesn't exist in the file}
#'   \item{AOB_HAULS_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{AOB_CATCHES}{order of the field in OAB catches file. NA if the field doesn't exist in the file}
#'   \item{AOB_CATCHES_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{AOB_LENGTHS}{order of the field in OAB lengths file. NA if the field doesn't exist in the file}
#'   \item{AOB_LENGTHS_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{AOB_LITTER}{order of the field in OAB litter file. NA if the field doesn't exist in the file}
#'   \item{AOB_LITTER_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{OAB_ACCIDENTALS}{order of the field in OAB accidental catches file. NA if the field doesn't exist in the file}
#'   \item{OAB_ACCIDENTALS_MANDATORY}{TRUE if the variable is mandatory in the import process}
#'   \item{COMMENTS}{Comments of field}
#'   ...
#' }
"formato_variables"
