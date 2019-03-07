#' Export to xlsx a list of dataframes
#'
#' This function create a xlsx file for each dataframe in a list of dataframes. The
#' name of every created file contains the name of its corresponding dataframe.
#'
#' @param list: list of dataframes
#' @param prefix: text to add after the name of the dataframe in the file exported. None by default.
#' @param suffix: text to add before the name of the dataframe in the file exported. None by default.
#' @param separation: characters to separate the prefix and suffix to the name of
#' the dataframe. By default is "_".
#' @return Save in the working directory a xlsx file for each dataframe in the
#' list of dataframes.
#' @export
#'

exportListToXlsx <- function (list, prefix = "", suffix = "", separation = "")
{
  #check if package openxlsx is instaled:
  if (!requireNamespace("openxlsx", quietly = TRUE)) {
    stop("Openxlsx package needed for this function to work. Please install it.",
         call = FALSE)
  }

  lapply(seq_along(list), function(i) {
    if (is.data.frame(list[[i]])) {

      list_name <- names(list)[[i]]
      if (prefix != "")
        prefix <- paste0(prefix, separation)
      if (suffix != "")
        suffix <- paste0(separation, suffix)
      filename <- paste0(PATH_ERRORS, "/", prefix, list_name, suffix, ".xlsx")

      # ---- Create a Workbook
      wb <- openxlsx::createWorkbook()

      # ---- Add worksheets
      name_worksheet <- paste("0",MONTH,sep="")
      openxlsx::addWorksheet(wb, name_worksheet)

      # ---- Add data to the workbook
      openxlsx::writeData(wb, name_worksheet, list[[i]])

      # ---- Useful variables
      num_cols_df <- length(list[[i]])

      # ---- Stylize data
      # ---- Create styles
      head_style <- openxlsx::createStyle(fgFill = "#EEEEEE",
                                fontName="Calibri",
                                fontSize = "11",
                                halign = "center",
                                valign = "center")

      # ---- Apply styles
      openxlsx::addStyle(wb, sheet = name_worksheet, head_style, rows = 1, cols = 1:num_cols_df)

      # ---- Column widths: I don't know why, but it dosn't work in the right way
      openxlsx::setColWidths(wb, name_worksheet, cols = c(1:num_cols_df), widths = "auto")

      # ---- Export to excel
      # source: https://github.com/awalker89/openxlsx/issues/111
      Sys.setenv("R_ZIPCMD" = "C:/Rtools/bin/zip.exe") ## path to zip.exe
      openxlsx::saveWorkbook(wb, filename, overwrite = TRUE)
    }
    else {
      return(paste("This isn't a dataframe"))
    }
  })
}
