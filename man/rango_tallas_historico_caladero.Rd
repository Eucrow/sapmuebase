% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rango_tallas_historico_caladero.R
\docType{data}
\name{rango_tallas_historico_caladero}
\alias{rango_tallas_historico_caladero}
\title{Historical size range by species and fishing ground.}
\format{
A data frame with 4 columns:
\describe{
  \item{COD_ESP}{SIRENO code species}
  \item{CALADERO}{Rim stratum}
  \item{TALLA_MIN}{minimun length}
  \item{TALLA_MAX}{maximun length}
  ...
}
}
\usage{
rango_tallas_historico_caladero
}
\description{
A dataset containing the historical size range by species and fishing ground,
obtained from type samples MT1B, MT2B and MT3 stored in RIM module of SIRENO
between 2014 and 2019. The lenghts has been revised with Cooks distance graphics.
The dataset is created in create_rango_tallas_historico_caladero.R.
}
\keyword{datasets}
