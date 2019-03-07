# ---- function to humanize dataframe ----------------------------------------
#
#' function to create new description columns from encoded variables of any dataframe
#' which have any of the encoded variables that is in dataset variables_format.
#'
#' @param df: dataframe to humanize
#' @return Return the original dataframe with the description columns added.
#' @import dplyr
#' @export
#'

humanize <- function(df){

  # check if package dplyr is instaled:
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("dplyr package needed for this function to work. Please install it.",
         call = FALSE)
  } else {
    library(dplyr)
  }

  column_names_df <- colnames(df)

  to_humanize <-variables_to_humanize[ variables_to_humanize[["ORIGINAL_VAR"]] %in% column_names_df, "ORIGINAL_VAR"]

  # apply humanizeVariable to the df
  # and return format errors if necessary
  for(i in to_humanize) {
    # humanizeVariable(df, i)
    tryCatch({
      df <- humanizeVariable(df, i)
    }
    , error = function(err){
      err <- paste(err, i, ". Variable hasn't been humnized.")
      print(err)
    }, warning = function(war){
      print(war)
    }
    )
  }

  # return humanized dataframe
  return(df)

}
