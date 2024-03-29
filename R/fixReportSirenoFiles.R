#' Split a line read by the function fix_import_files.
#' Used in fix_import_files() function.
#' If the last character of the line is a separator character, the last
#' column is lost. So, if the last character is a ";", add a white space to
#' the last line to avoid it.
split_line <- function(line){
  if (line == ""){
    warning("The line is empty")
  }

  # if the file last character is a ";":
  size_line <- nchar(line)
  last_character <- substr(line, size_line, size_line)
  if(last_character == ";"){
    line <- paste0(line, " ")
  }

  # split the line:
  line <- strsplit(line, ";")
  line <- unlist(line)
}


#' Fix erroneous format of the reports from SIRENO in the 'observations' variable.
#' Sometimes in SIRENO, in 'observations' variable, a semicolon or a enter is
#' saved. When SIRENO generate the report files, the 'observations' variable is
#' exported as it is, with the semicolon and enter characters. This means that
#' some lines of the file have more than the theoretical number of variables (when
#' observations variable have a semicolon inside) or less than the theoretical
#' (when a enter character is in the observations variable of the previous row).
#'
#' This function check the number of variables and works as follow:
#' - If the number of variables is the same of the theoretical, there aren't any
#' changes.
#' - When there are more variables than theoretical, the last variables are
#' collapsed in the last one and changed the ";" to "." inside the observations
#' variable
#' - When there are less variable than the theoretical, we assume an enter has
#' been saved in the observations variable of the previous row and after
#' the enter there are more semicolons. The content of this row is added to the
#' variable observation of the previous row and the ";" is changed to ".".
#'
#' @param filename File name of the file to check.
#' @param filetype Type of file: RIM_CATCHES, RIM_CATCHES_IN_LENGTHS,
#' RIM_LENGTHS, OAB_TRIPS, OAB_HAULS, OAB_CATCHES, OAB_LENGTHS, OAB_LITTER,
#' OAB_ACCIDENTAL
#' @param path Path of the file.
#' @param temporal If is True, the file is exported in a temporal directory. This is
#' useful when this function is used with sapmuebase import functions. When is
#' false, the fixed report is exported in the path location
#'
#' @note Use this function carefully, if the format or the sireno reports
#' changed can produce unexpected results. Furthermore, only is appropriate when
#' the 'observations' field is the last one of the row.
#'
#' @export
fixReportSirenoFiles <- function(filename, filetype, path = getwd(), temporal = F) {

  path_complete <- paste(path, filename, sep="/")

  con <- file(path_complete, "r", encoding = "Windows-1252")

  # theoretical number of variables
  type_variables <- sapmuebase:::getVariableTypes(filetype, "class_variable_final")
  novt <- nrow(type_variables)

  # create empty list
  new_list <- list()

  # get the column names
  column_names <- readLines(con, n = 1)
  column_names <- strsplit(column_names, ";")
  column_names <- unlist(column_names, use.names = F)

  # loop by every line of the file
  while ( TRUE ) {
    new_line = readLines(con, n = 1)

    if ( length(new_line) == 0 ) {
      break
    }

    # split the line in a character vector
    new_row <- split_line(new_line)

    # number of variables of the line
    nov <- length(new_row)

    # depending of the number of variables of the row:
    if (nov == novt) {
      # the number of variables is the same of the theorical, so there aren't
      # any changes
      new_list[[length(new_list)+1]] <- new_row

    } else if (nov > novt){
      # when there are more variables than theorical, the last variables are
      # collapsed in the last one
      last_variable <- paste0(new_row[novt:nov], collapse = ".")

      new_row <- c(new_row[1:(novt-1)], last_variable)

      new_list[[length(new_list)+1]] <- new_row

    } else if (nov < novt){
      # when there are less variable than the theorical, we asume an enter has
      # been saved in the observations variable of the previous row and after
      # the enter there are more semicolons.

      # previous observation variable:
      p_obs <- new_list[[length(new_list)]][novt]

      # new observation variable:
      n_obs <- paste0(p_obs, new_row, collapse = ". ")

      # update previous row with the new obsertion variable:
      new_list[[length(new_list)]][novt] <- n_obs
    }
  }

  close(con)

  # add column names
  new_data_frame <- do.call(rbind.data.frame, new_list)
  if (ncol(new_data_frame)==0) {
    new_data_frame <- data.frame(matrix(ncol = nrow(type_variables), nrow = 0))
  }

  names(new_data_frame) <- column_names

  # export file:
  if ( temporal == F ){
    name_file <- substr(filename, 1, nchar(filename)-4)
    extension_file <- substr(filename, nchar(filename)-3, nchar(filename))
    final_name <- paste0(name_file, "_fixed", extension_file)
    exportCsvSAPMUEBASE(new_data_frame, final_name, path = path)
  } else if ( temporal == T ){
    exportCsvSAPMUEBASE(new_data_frame, filename, path = tempdir())
  }


}

