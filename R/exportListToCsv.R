#' Export to csv a list of dataframes
#'
#' This function create a csv file for each dataframe in a list of dataframes.
#'
#' @param list of dataframes
#' @return Save in the working directory a csv file for each dataframe in the
#' list of dataframes.
#' @export
#'
#'
#'
exportListToCsv <- function(list){

  lapply(seq_along(list), function(i){

    if(is.data.frame(list[[i]])){
      list_name <- names(list)[[i]]
      filename <- paste(list_name, ".csv", sep = "")
      write.csv(list[[i]], file = filename, quote = FALSE, row.names = FALSE)
    } else {
      return(paste("This isn't a dataframe"))
    }

  })

}
