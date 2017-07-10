# ---- function to import the Lengths file from 'tallas por up' report ---------
#' Import the Lenghts file from 'tallas por up' report
#'
#' This function import the lengths files obtained from 'muestreos tallas por up'
#' reports in SIRENO.
#'
#' Multiple files can be imported at the same time.
#'
#' To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and 'TRIMESTRE'
#' are created in the returned dataframe.
#'
#' @param file vector with the total landings filenames
#' @param path path of the files. The working directory by default.
#' @return Return dataframe.
#' @export
importLengths <- function(file, path = getwd()){
  lengths <- lapply(
    file,
    function(x){
      tryCatch({
        fullpath <- paste(path, x, sep="/")
        type <- formato_variables[formato_variables[["LENGTHS"]]==T, "class_variable_final"]
        read.table(fullpath, sep=";", header = TRUE, quote = "",
                   colClasses = type)

      },
      error = function(err) {
        error_text <- paste("error in file", x, ": ", err)
        stop(error_text)
      }
      )
    }
  )
  lengths <- Reduce(rbind, lengths)

  lengths <- formatImportedFile(lengths)
}
