#' Convert logical varible in spanish (S/N) to logical TRUE/FALSE.
#' @param x vector to convert. Only admit "S" or "N" values.
#' @return vector var converted as logical. In case a value is distinct of "S"
#' or "N", an error is thrown.
#' @export

convertSNtoLogical <- function(x){

  x <- as.character(x)

  unique_values <- unique(x)

  if (!all(grepl("^S|N$", x))){
    stop(paste("The", x, "variable contains values distinct of S or N."))
  }

  x[which(x == "S")] <- TRUE
  x[which(x == "N")] <- FALSE

  x <- as.logical(x)

  return(x)

}
