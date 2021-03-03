#' @title Check in WORMS if one species belongs to a taxon.
#' @param specie Specie to check.
#' @param taxon_to_match Taxon to match.
#' @return TRUE if the species belong to taxon. False if doesn't. In case any species
#' doesn't exists in WORMS a warning is thrown and the text "this species
#' doesn't match in WORMS" is returned. In case multiple matchs, a warning is
#' thrown and the text "multiple match in WORMS" is returned.
#' @details Uses WORMS api to identify the species taxon.
#'
#' If the species contains the abbreviation spp, the " spp" is removed in
#' order to find a match in WORMS.
#'
#' Require jsonlite library.
#' @author Marco A. Ámez , \email{marco.amez@@ieo.es}
spBelongsToTaxon <- function (species, taxon_to_match){

  # Remove spp abbreviation
  species <- removeSppFrom_Sp(species)

  # Get the AphiaID of the species
  # I don't use worms package because I'm interested in catch the response in case
  # of the species does not exists in WORMS
  url_species <- paste0("http://www.marinespecies.org/rest/AphiaIDByName/", species)
  url_species <- gsub(" ", "%20", url_species)
  print(url_species)
  resp <- httr::GET(url_species)
  if (resp$status_code==204){
    warning(paste(species, "doesn't match in WORMS"))
    return("this species doesn't match in WORMS")
  }
  if (resp$status_code==206){
    warning(paste(species, "has multiple matchs in WORMS"))
    return("multiple match in WORMS")
  }

  AphiaID_species <- jsonlite::fromJSON(url_species)

  #Build the URL to get the data from
  url <- sprintf("http://www.marinespecies.org/rest/AphiaClassificationByAphiaID/%d", AphiaID_species);

  #Get the actual data from the URL
  tryCatch({
    classificationTree <- jsonlite::fromJSON(url)

    #Walk the classification tree
    currentTreeItem = classificationTree
    while (!is.null(currentTreeItem )) {
      if (currentTreeItem$scientificname == taxon_to_match){
        return(TRUE)
      } else {
        #Get next item in the tree
        currentTreeItem <- currentTreeItem$child;
      }
    }

    return(FALSE)

  },
  error = function(e){
    return(e$message)
  }
  )

}
