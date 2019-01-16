# ---- function to import the 'tallas por up' files ----------------------------
#' Import 'muestreos tallas por up'
#'
#' This function import the three files obtained from 'muestreos tallas por up'
#' reports in SIRENO: total catches file, catches of length samples file and lengths
#' file.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' are created in the returned dataframe.
#'
#' @param des_tot vector with the total landings filenames
#' @param des_tal vector with the landings of the lengths samples filenames
#' @param tal vector with the lengths samples filenames
#' @param by_month to filter only by one month. Numeric between 1 to 12 to select
#' one month or FALSE for all the year. FALSE by default.
#' @param path path of the files. The working directory by default.
#' @param export to export muestreos_up dataframe in csv file. False by default.
#' @aliases importMuestreosUP
#' @return Return a list with 3 data frames
#' @export

importRIMFiles <- function(des_tot, des_tal, tal, by_month = FALSE, export = FALSE, path = getwd()){

  # check des_tot, des_tal and tal has the same length
  if(length(des_tot) != length(des_tal) | length(des_tot) != length(tal)){
    stop(paste0("the variables", des_tot, ", ", des_tal, ", ", tal, "does not have the same length."))
  }

  # import files
  catches <- importRIMCatches(des_tot, path)

  catches_in_lengths <- importRIMCatchesInLengths(des_tal, path)

  lengths <- importRIMLengths(tal, path)

  # group in a list
  muestreos_up<-list(catches_in_lengths=catches_in_lengths, lengths=lengths, catches=catches)

  if ( check_by_month_argument(by_month) ){
    muestreos_up <- lapply(muestreos_up, function(x){x <- filter_by_month(x, by_month); x})
  }


  if (isTRUE(export)){
    exportListToCsv(muestreos_up)
  }

  #return list
  return(muestreos_up)
}
