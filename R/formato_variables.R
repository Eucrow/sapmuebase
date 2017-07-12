#' Variables format
#'
#' A dataset containing the format of the variables in the tallas_x_up report files from SIRENO
#' with another information structure.
#'
#' @format A data frame with 9 columns:
#' \describe{
#'   \item{name_variable}{name of the variable}
#'   \item{regex_variable_import}{regular expression of the variable in the import process}
#'   \item{class_variable_import}{class of the variable in the import process}
#'   \item{mandatory}{TRUE if the variable is mandatory for the import process}
#'   \item{regex_variable_final}{regular expression that should be the variable after import process}
#'   \item{class_variable_final}{class that should be the variable after import process}
#'   \item{CATCHES}{TRUE if the variable is in catches file}
#'   \item{CATCHES_IN_LENGTHS}{TRUE if the variable is in catches_in_lengths file}
#'   \item{LENGTHS}{TRUE if the variable is in lengths file}
#'   ...
#' }
"formato_variables"
