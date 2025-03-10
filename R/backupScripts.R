#' Function make a backup of multiple files to a folder.
#'
#' @param files_to_backup character vector with files to backup.
#' @param path_files path where the files to backup are. By default the actual
#' working directory.
#' @param path_backup path where save the backup files.
#' @details If any files of the files_to_backup already exists in path_backup,
#' the function ask for overwrite all the files.
#'
#' If the name of the files to backup include a directory, like "data/df1.csv",
#' the function create the directory first.
#'
#' @return A logical vector of the length of the files_to_backup with TRUE when
#' the file is properly saved and false if doesn't.
#' @export

backupScripts <- function(files_to_backup, path_files=getwd(), path_backup) {

  # if the backup directory does not exists, create it:
  ifelse(!dir.exists(path_backup), dir.create(path_backup), FALSE)

  # make backup
  files_to_backup_from <- file.path(path_files, files_to_backup)
  files_to_backup_to <-  file.path(path_backup, files_to_backup)

  if (any(file.exists(files_to_backup_to))) {
    if(readline(prompt = "Some of the files already exists, overwrite? (y/n)") %in% c("y", "Y")){
      file.copy(files_to_backup_from, files_to_backup_to, overwrite = TRUE)
    } else {
      print("Nothing has been saved.")
    }
  } else {
    # Just in case the name of any file to backup include a directory, like
    # "data/df1.csv", we need to create the directory first
    folder_names <- unique(dirname(files_to_backup_to))
    lapply(folder_names, function(x) if(dir.exists(x)==FALSE) dir.create(x, recursive = TRUE))

    file.copy(files_to_backup_from, files_to_backup_to, overwrite = TRUE)
  }

}
