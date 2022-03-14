checkStructureFileNameOfFields <- function (df, file_type)
{
  available_variables <- c("RIM_CATCHES",
                           "RIM_CATCHES_IN_LENGTHS",
                           "RIM_LENGTHS",
                           "OAB_TRIPS",
                           "OAB_HAULS",
                           "OAB_CATCHES",
                           "OAB_LENGTHS",
                           "OAB_LITTER",
                           "OAB_ACCIDENTALS"
  )

  if ( !(file_type %in% available_variables) ){
    available_variables <- paste(available_variables, collapse = " ")
    stop(paste("file_type incorrect:", file_type, "Only ", available_variables, "are available"))
  }

  df_colnames <- colnames(df)
  df_colnames <- data.frame(original_name_variable = df_colnames)
  df_colnames <- merge(df_colnames, relacion_variables, all.x = T, sort = F)


  correct_colnames <- formato_variables %>%
    select(one_of(c("name_variable", file_type))) %>%
    na.omit() %>%
    arrange_(file_type)

  if (!identical(df_colnames[["name_variable"]], correct_colnames[["name_variable"]])) {
    err_names <- df_colnames[is.na(df_colnames$name_variable), "original_name_variable"]
    err_names <- paste(err_names, collapse=', ')
    err_comment <- paste0("The dataframe doesn't have the appropriate column
    names. Check this column names: ", err_names, " with 'relacion_variables'
                          and 'formato_variables' dataset.")
    stop(err_comment)
  }
}

checkStructureFileNumberOfFields <- function (df, file_type){

  available_variables <- c("RIM_CATCHES",
                           "RIM_CATCHES_IN_LENGTHS",
                           "RIM_LENGTHS",
                           "OAB_TRIPS",
                           "OAB_HAULS",
                           "OAB_CATCHES",
                           "OAB_LENGTHS",
                           "OAB_LITTER",
                           "OAB_ACCIDENTALS"
                           )

  if ( !(file_type %in% available_variables) ){
    available_variables <- paste(available_variables, collapse = " ")
    stop(paste("file_type incorrect:", file_type, "Only ", available_variables, "are available"))
  }

  number_of_variables <- length(which(!is.na(formato_variables[[file_type]])))

  if (ncol(df) != number_of_variables) {
    stop("The dataframe doesn't have the appropriate number of columns.")
  }

}

#' Check the correct structure file of tallas_x_up SIRENO reports.
#'
#' Compare the correct number and name of the variables of a df with the structure
#' in 'formato_variables' dataset in order to check the appropiate format.
#'
#' WARNING: the dataframe must be obtained from a read.table, read.csv or similar
#' {base} function. I'ts not available to use after the import with
#' importRIMCatches(), importRIMLengths(), importRIMCatchesInLengths()...
#'
#' This function is called inside import SIRENO files functions like
#' importRIMCatches(), importRIMLengths()...
#'
#'
#' @param df df to check.
#' @param file_type Type of df: "CATCHES", "CATCHES_IN_LENGTHS", "LENGTHS",
#' "OAB_TRIPS", "OAB_HAULS", "OAB_CATCHES" or "OAB_LENGTHS".
#' @return Two possible errors: 'The dataframe doesn't have the appropriate column names'
#' or 'The dataframe doesn't have the appropriate number of columns'. In case the
#' structure is correct, doesn't return anything.
#' @export
# TO DO: the function should return TRUE if the structure is correct

checkStructureFile <- function (df, file_type){

  tryCatch(
    checkStructureFileNumberOfFields(df, file_type)
  )

  tryCatch(
    checkStructureFileNameOfFields(df, file_type)
  )

}
