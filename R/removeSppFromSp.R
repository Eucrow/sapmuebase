#' @title Remove " spp" abbreviation in species.
#' @param sp A character vector of species.
#' @return A character vector of species without " spp".
#' @author Marco A. Ámez , \email{marco.amez@@ieo.es}
removeSppFrom_Sp <- function(sp){
  return (gsub(" spp$", "", sp))
}
