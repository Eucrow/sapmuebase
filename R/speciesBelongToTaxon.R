#' Return species belonging to certain taxon.
#' @param species vector of species to check.
#' @param taxon taxon.
#' @return vector with the species belonging to taxon. For every species, TRUE
#' if belongs to taxon. False if doesn't. In case the species
#' doesn't exists in WORMS a warning is thrown and the text "this species
#' doesn't match in WORMS" is returned. In case multiple matchs, a warning is
#' thrown and the text "multiple match in WORMS" is returned.
#' @details Is the vectorized version of check_spe_belongs_to_taxon().
#' Uses WORMS api to identify the species taxon.
#' If the species contains the abbreviation spp, the " spp" is removed in
#' order to find a match in WORMS.
#' @author Marco A. Ámez , \email{marco.amez@@ieo.es}
#' @export
speciesBelongToTaxon <- function(species, taxon){

  species <- apply(as.matrix(species), 1, spBelongsToTaxon, taxon)

  return(species)

}
