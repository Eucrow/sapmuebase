#' Indicates if vessel is active in the Spanish SGP (Secretaría General de Pesca)
#' vessel census.
#'
#' @param cfr ship CFR code.
#' @return True if the ship is active, False if it doesn't.
#' @export
isVesselActive <- function(cfr){

  result <- lapply(cfr, function(x){

    sgp_vessel_id <- getSGPVesselId(x)

    base_url <- paste0("https://servicio.pesca.mapama.es/CENSO/ConsultaBuqueRegistro/Buques/Details/", sgp_vessel_id)

    req <- httr2::request(base_url)

    res <- httr2::req_perform(req)

    res_html <- httr2::resp_body_html(res)

    res_text <- as.character(res_html)

    search_pattern <- "Alta Definitiva|Alta Provisional"

    status <- regmatches(res_text, regexpr(search_pattern, res_text))

    if(length(status)!=0){
      return (TRUE)
    } else {
      return(FALSE)
    }

  })

  result <- unlist(result)

  return(result)

}
