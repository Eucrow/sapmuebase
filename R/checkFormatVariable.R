# ---- function to check variable format----------------------------------------
#
#' Function to check the correct format of a variable of a dataframe
#' obtained by importMuestreosUP() function.
#'
#' The format of the variables is in dataset variables_format.
#'
#' @param df: dataframe with the format variable to check
#' @param var_to_check: variable to check
#' @return TRUE if the format is correct. Return a named list of vectors if there are any mistake.
#' The name of the vector is the variable with errors. Every vector contains list of index with errors.
#' @export
#'
checkFormatVariable <- function(df, var_to_check){

  #import variables format file
  # variables_format <- read.table(file = "formato_variables.csv", row.names = NULL, header = TRUE, sep = ";", fill = TRUE, as.is = T)

  # check format
  # format_regex <- variables_format[variables_format[["name_variable"]] == var_to_check, "regex_variable_import"]
  format_regex <- formato_variables[formato_variables[["name_variable"]] == var_to_check, "regex_variable_import"]

  errors <- list()

  if (all(grepl(format_regex, df[[var_to_check]]))) {

    return(TRUE)

  } else {

    errors[[var_to_check]] <- grep(format_regex, df[[var_to_check]], invert = TRUE)

    errors <- paste(errors[[var_to_check]], collapse = ",")

    errors <- paste("Error in the", var_to_check, "format. Check this rows:", errors)

    stop(errors)
  }
}
