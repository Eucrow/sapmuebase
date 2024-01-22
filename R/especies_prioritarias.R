#' Priority species
#'
#' A data set with the priority species in sampling and its priority group.
#'
#' The priority is related to the species in the column ESP_MUE. The column
#' ESP_CAT show the same species than ESP but with the grouped species expanded
#' with the ones usually sampled in SAP.
#'
#'
#' @format A data frame with 6 columns:
#' \describe{
#'   \item{PRIORIDAD}{Priority group.}
#'   \item{COD_ESP_MUE}{Code of the species sampling.}
#'   \item{ESP_MUE}{Scientific name of species sampling.}
#'   \item{COD_ESP_CAT}{Code of the species of the category.}
#'   \item{ESP_CAT}{Scientific name of the the species of the category.}
#'   \item{ORIGEN}{Origin where the species have priority. If it is empty, the
#'   priority is for any origin.}
#'   ...
#' }

"especies_prioritarias"
