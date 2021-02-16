#' Historical size range by species and fishing ground.
#'
#' A dataset containing the historical size range by species and fishing ground,
#' obtained from type samples MT1B, MT2B and MT3 stored in RIM module of SIRENO
#' between 2014 and 2019. The lenghts has been revised with Cooks distance graphics.
#' The dataset is created in create_rango_tallas_historico_caladero.R.
#'
#' @format A data frame with 4 columns:
#' \describe{
#'   \item{COD_ESP}{SIRENO code species}
#'   \item{CALADERO}{Rim stratum}
#'   \item{TALLA_MIN}{minimun length}
#'   \item{TALLA_MAX}{maximun length}
#'   ...
#' }

"rango_tallas_historico_caladero"
