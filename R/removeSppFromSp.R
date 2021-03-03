#' Remove " spp" abbreviation in species.
#' @param sp a character vector of species.
#' @return a character vector of species without " spp".
#' @author Marco A. Ámez , \email{marco.amez@@ieo.es}
removeSppFrom_Sp <- function(sp){
  return (gsub(" spp$", "", sp))
}
