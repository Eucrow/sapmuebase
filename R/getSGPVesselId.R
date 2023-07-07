#' Get vessel identification code of Spanish SGP (Secretaría General de Pesca)
#' vessel census.
#'
#' @param cfr ship CFR code.
#' @return identification code in SGP census.
#' @note The identification code is only used by Spanish SGP.
#' @export
getSGPVesselId <- function(cfr){

  result <- lapply(cfr, function(x){
    if (vesselInSGPFleet(x) == FALSE){
      stop(paste0("This vessel doesn't exists in the SGP fleet census: ", x))
    }

    base_url <- "https://servicio.pesca.mapama.es/CENSO/ConsultaBuqueRegistro/Buques/Search?text="

    req <- httr2::request(paste0(base_url, x))

    res <- httr2::req_perform(req)

    res_html <- httr2::resp_body_html(res)

    res_text <- as.character(res_html)
    search_pattern <- "\\/CENSO\\/ConsultaBuqueRegistro\\/Buques\\/Details\\/\\d+\\?foundSearchingText"

    id_vessel <- regmatches(res_text, gregexec(search_pattern, res_text))

    return (regmatches(id_vessel, regexpr("\\d+", id_vessel)))

  })

  result <- unlist(result)

  return(result)

}
