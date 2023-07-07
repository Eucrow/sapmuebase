#' Detect if a vessel exists in Spanish SGP (Secretaría General de Pesca)
#' census.
#'
#' @param cfr ship CFR code.
#' @return True if the vessel exists, False if it doesn't.
#' @export
vesselInSGPFleet <- function(cfr){
  base_url <- "https://servicio.pesca.mapama.es/CENSO/ConsultaBuqueRegistro/Buques/Search?text="

  result <- lapply(cfr, function(x){
    req <- httr2::request(paste0(base_url, x))

    res <- httr2::req_perform(req)

    res_html <- httr2::resp_body_html(res)

    res_text <- as.character(res_html)

    search_pattern <- "\\/CENSO\\/ConsultaBuqueRegistro\\/Buques\\/Details\\/\\d+\\?foundSearchingText"

    id_vessel <- regmatches(res_text, gregexec(search_pattern, res_text))

    if(length(id_vessel[[1]]) == 1){
      return(TRUE)
    } else if(length(id_vessel[[1]]) == 0) {
      return(FALSE)
    } else if(length(id_vessel[[1]]) > 1){
      stop(paste0("There are multiple vessels with this CFR: ", x))
    }

  })

  return(result)
}
