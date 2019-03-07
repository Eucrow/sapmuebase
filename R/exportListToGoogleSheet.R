#' Export a list of dataframes to a google sheet
#'
#' This function create a google sheet file for each dataframe in a list of dataframes and upload it. The
#' name of every created file contains the name of its corresponding dataframe.
#'
#'
#' @param list: list of dataframes
#' @param prefix: text to add after the name of the dataframe in the file exported. None by default.
#' @param suffix: text to add before the name of the dataframe in the file exported. None by default.
#' @param separation: characters to separate the prefix and suffix to the name of
#' the dataframe. By default is "_".
#' @return Save in the working directory a google sheet file for each dataframe in the
#' list of dataframes.
#' The first time this function is run, R console show a link to open in a browser
#' where a username, password and permissions are asked.
#' @export
#'

exportListToGoogleSheet <- function(list, prefix = "", suffix = "", separation = ""){

  #check if package openxlsx is instaled:
  if (!requireNamespace("googlesheets", quietly = TRUE)) {
    stop("Googlesheets package needed for this function to work. Please install it.",
         call = FALSE)
  }

  # sep_along(list): generate regular sequences. With a list, generates
  # the sequence 1, 2, ..., length(from). Return a integer vector.
  lapply(seq_along(list), function(i){

    list[[i]][["PUERTO"]] <- iconv(list[[i]][["PUERTO"]], "windows-1252", "UTF-8")
    list[[i]][["BARCO"]] <- iconv(list[[i]][["BARCO"]], "windows-1252", "UTF-8")
    #list[[i]][["CATEGORIA"]] <- iconv(list[[i]][["CATEGORIA"]], "windows-1252", "UTF-8")
    list[[i]][["TIPO_ERROR"]] <- iconv(list[[i]][["TIPO_ERROR"]], "windows-1252", "UTF-8")

    if(is.data.frame(list[[i]])){

      list_name <- names(list)[[i]]

      if (prefix != "") prefix <- paste0(prefix, separation)

      if (suffix != "") suffix <- paste0(separation, suffix)

      filename <- paste0(prefix, list_name, suffix, ".csv")

      googlesheets::gs_new(filename, ws_title = filename, input = list[[i]],
             trim = TRUE, verbose = FALSE)

    } else {
      return(paste("This isn't a dataframe"))
    }

  })
}
