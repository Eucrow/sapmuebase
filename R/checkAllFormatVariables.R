# ---- function to check all the variables format-------------------------------
#
#' Function to check all the variables format of a dataframe obtained by
#' importMuestreosUP() function.
#'
#' The format of every variable is in variables_format dataset.
#'
#' @param df: dataframe with the format variable to check
#' @return TRUE if the format is correct. Return a named list of vectors if there are any error.
#' The name of the vector is the variable with errors. Every vector contains the
#' rows index of df with errors.
#' @export
#'
checkAllFormatVariables <- function (df){

  to_check <- colnames(df)

  errors <- lapply(
    to_check,
    function(x){
      checkFormatVariable(df, x)
    })

  #remove true elements of the errors (because doesn't contain errors):
  errors <- errors[!errors %in% TRUE]

  return(errors)

}
