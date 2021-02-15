#' Convert logical varible in spanish (S/N) to logical TRUE/FALSE.
#' @param x vector to convert. Only admit "S", "N" or empty values. Empty values
#' are assumed as FALSE.
#' @return vector var converted as logical. In case a value is distinct of "S",
#' "N" or empty value, an error is thrown.
#' @export

convertSNtoLogical <- function(x){

  x <- as.character(x)

  # the regex expression "^\b|S|N$" means any empty value, or 'S' or 'N'.
  if (!all(grepl("^\b|S|N$" , x))){
    stop("The variable only can contain 'S', 'N' or empty values.")
  }

  x[which(x == "S")] <- TRUE
  x[which(x == "N")] <- FALSE

  x <- as.logical(x)

  return(x)

}
