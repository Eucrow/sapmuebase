#' Variables to humanize
#'
#' A dataset with the variables suitable to humanize.
#' Contains to the data necessary to allow the humanize process.
#'
#' @format A data frame with 4 columns:
#' \describe{
#'   \item{ORIGINAL_VAR}{Variable suitable to humanize.}
#'   \item{MASTER_VAR}{Name of the ORIGINAL_VAR in the master. This column is
#'   neccesary because in some cases the name of the variable in the master
#'   is different that the ORIGINAL_VAR.}
#'   \item{HUMANIZED_VAR}{Name of the humanized variable. The humanized variable
#'   is the value returned by humanized functions.}
#'   \item{MASTER}{Master in wich the variable is coded.}
#'   ...
#' }

"variables_to_humanize"
