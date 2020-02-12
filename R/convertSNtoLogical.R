#' Convert logical varible in spanish (S/N) to logical TRUE/FALSE.
#' @param x vector to convert. Only admit "S", "N" or empty values. Empty values
#' are assumed as FALSE.
#' @return vector var converted as logical. In case a value is distinct of "S"
#' or "N", an error is thrown.
#' @export

convertSNtoLogical <- function(x){

  x <- as.character(x)

  unique_values <- unique(x)

  if (!all(grepl("^S|N$", x))){
    warning("When data S/N are converted to TRUE/FALSE, the empty data are assumed as FALSE.")
    x[which(x == "")] <- FALSE
  }

  x[which(x == "S")] <- TRUE
  x[which(x == "N")] <- FALSE

  x <- as.logical(x)

  return(x)

}
