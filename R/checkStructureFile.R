checkStructureFileNameOfFields <- function (df, typeOfFile){

  df_colnames <- colnames(df)

  correct_colnames <- formato_variables[formato_variables[[typeOfFile]]==TRUE, "name_variable"]

  if(!identical(df_colnames, correct_colnames)){
    stop("The dataframe doesn't have the appropriate column names. Check the column names with 'formato_variables' dataset.")
  }

}

checkStructureFileNumberOfFields <- function (df, typeOfFile){

  if (typeOfFile != "CATCHES" & typeOfFile != "CATCHES_IN_LENGTHS" & typeOfFile != "LENGTHS"){
    stop("typeOfFile incorrect: Only CATCHES, CATCHES_IN_LENGTHS or LENGTHS are available")
  }

  number_of_variables <- length(which(formato_variables[[typeOfFile]]==TRUE))

  if (ncol(df) != number_of_variables) {
    stop("The dataframe doesn't have the appropriate number of columns.")
  }

}

#' Check the correct structure file of tallas_x_up SIRENO reports.
#'
#' Compare the correct number and name of the variables of a file with the structure
#' in 'formato_variables' dataset in order to check the appropiate format.#'
#'
#'
#' @param file file to check.
#' @param typeOfFile Type of file: "CATCHES", "CATCHES_IN_LENGTHS" or "LENGTHS".
#' @return Two possible errors: 'The dataframe doesn't have the appropriate column names'
#' or 'The dataframe doesn't have the appropriate number of columns'. In case the
#' structure is correct, doesn't return nothing.
#' @export

checkStructureFile <- function (file, typeOfFile){

  tryCatch(
    checkStructureFileNumberOfFields(file, typeOfFile)
  )

  tryCatch(
    checkStructureFileNameOfFields(file, typeOfFile)
  )

}
