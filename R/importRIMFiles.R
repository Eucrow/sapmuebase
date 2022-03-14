# ---- function to import the 'tallas por up' files ----------------------------
#' Import 'muestreos tallas por up'
#'
#' This function import the three files obtained from 'muestreos tallas por up'
#' reports in SIRENO: total catches file, catches of length samples file and lengths
#' file.
#'
#' @param catches vector with the total landings filenames
#' @param catches_in_lengths vector with the landings of the lengths samples filenames
#' @param lengths vector with the lengths samples filenames
#' @param by_month to filter only by one month. Numeric between 1 to 12 to select
#' one month or FALSE for all the year. FALSE by default.
#' @param path path of the files. The working directory by default.
#' @param export to export muestreos_up dataframe in csv file. False by default.
#' @aliases importMuestreosUP
#' @return Return a list with 3 data frames
#' @export

importRIMFiles <- function(catches, catches_in_lengths, lengths, by_month = FALSE, export = FALSE, path = getwd()){

  # check vector of des_tot, des_tal and tal has the same length
  if(length(catches) != length(catches_in_lengths) | length(catches) != length(lengths)){
    stop(paste0("the variables", catches, ", ", catches_in_lengths, ", ", lengths, "does not have the same length."))
  }

  # create a list of functions
  df_functions <- list("catches" = importRIMCatches,
                       "catches_in_lengths" = importRIMCatchesInLengths,
                       "lengths" = importRIMLengths)

  # whit this apply, for every import function of df_functions, execute it
  # inside a tryCatch returning the result of the function or the error thrown.
  samples_rim <- lapply(seq(1:length(df_functions)), function(x, y){

    name_of_df <- names(y)[x]

    df_data <- tryCatch(
      y[[x]](get(name_of_df), path),
      # get(y[x])(name_of_df, path),
      error = function(e){
        # return(e)
        warning(e)
      }
    )

  }, df_functions)

  names(samples_rim) <- names(df_functions)

  # fix format in case of the import function return an error.
  samples_rim <- lapply(samples_rim, function(x){
    if(exists("message", where = x)){
      return(x[["message"]])
    } else {
      return(x)
    }
  })

  # filter by month
  if ( check_by_month_argument(by_month) ){
    if(by_month != FALSE){
      samples_rim <- lapply(samples_rim, function(x){x <- filter_by_month(x, by_month); x})
    }
  }


  if (isTRUE(export)){
    exportListToCsv(samples_rim)
  }

  #return list
  return(samples_rim)
}
