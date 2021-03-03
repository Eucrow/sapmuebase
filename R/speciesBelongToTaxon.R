#' @title Check in WORMS if species belongs to a taxon.
#' @param species Vector of species to check.
#' @param taxon Taxon as character.
#' @return Vector with the species belonging to taxon. For every species, TRUE
#' if belongs to taxon. False if doesn't. In case the species
#' doesn't exists in WORMS a warning is thrown and the text "this species
#' doesn't match in WORMS" is returned. In case multiple matchs, a warning is
#' thrown and the text "multiple match in WORMS" is returned.
#' @details Is the vectorized version of check_spe_belongs_to_taxon().
#'
#' Uses WORMS api to identify the species taxon.
#'
#' If the species contains the abbreviation spp, the " spp" is removed from
#' the name in order to find a match in WORMS.
#' @examples
#' > species_to_check <- c("Loligo vulgaris", "Raja clavata", "Sardina pilchardus")
#' > speciesBelongToTaxon(species_to_check, "Elasmobranchii")
#' [1] FALSE  TRUE FALSE
#' @author Marco A. Ámez , \email{marco.amez@@ieo.es}
#' @export
speciesBelongToTaxon <- function(species, taxon){

  species <- apply(as.matrix(species), 1, spBelongsToTaxon, taxon)

  return(species)

}
