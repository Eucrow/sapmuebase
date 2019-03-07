#' Export to csv a list of dataframes
#'
#' This function create a csv file for each dataframe in a list of dataframes. The
#' name of every created file contains the name of its corresponding dataframe.
#'
#' @param list: list of dataframes
#' @param prefix: text to add after the name of the dataframe in the file exported. None by default.
#' @param suffix: text to add before the name of the dataframe in the file exported. None by default.
#' @param separation: characters to separate the prefix and suffix to the name of
#' the dataframe. By default is "_".
#' @param path = destiny path. By default is the actual working directory.
#' @return Save in the working directory a csv file for each dataframe in the
#' list of dataframes.
#' @export
#'
#'
#'
exportListToCsv <- function(list, prefix = "", suffix = "", separation = "", path = getwd()){

  # sep_along(list): generate regular sequences. With a list, generates
  # the sequence 1, 2, ..., length(from). Return a integer vector.
  lapply(seq_along(list), function(i){

    if(is.data.frame(list[[i]])){

      list_name <- names(list)[[i]]

      if (prefix != "") prefix <- paste0(prefix, separation)

      if (suffix != "") suffix <- paste0(separation, suffix)

      filename <- paste0(path, "/", prefix, list_name, suffix, ".csv")

      write.table(list[[i]], file=filename, quote = FALSE, row.names = FALSE, dec = ",", sep = ";", na = "")

    } else {

      return(paste("This isn't a dataframe"))

    }

  })

}
