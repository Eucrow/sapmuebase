#' Backup scripts and related files.
#'
#' @param files_to_backup character vector with files to backup.
#' @param path_files path where the files to backup are. By default the actual
#' working directory.
#' @param path_backup path where save the backup files.
#' @details If any files of the files_to_backup already exists in path_backup,
#' the function ask for overwrite all the files.
#' @return A logical vector of the lenght of the files_to_backup with TRUE when
#' the file is properly saved and false if doesn't.
#' @export

backupScripts <- function(files_to_backup, path_files=getwd(), path_backup) {

  # if the backup directory does not exists, create it:
  ifelse(!dir.exists(path_backup), dir.create(path_backup), FALSE)

  # make backup
  files_to_backup_from <- file.path(getwd(), files_to_backup)
  files_to_backup_to <-  file.path(path_backup, files_to_backup)

  if (any(file.exists(files_to_backup_to))) {
    if(readline(prompt = "Some of the files already exists, overwrite? (y/n)") %in% c("y", "Y")){
      file.copy(files_to_backup_from, files_to_backup_to, overwrite = TRUE)
    } else {
      print("Nothing has been saved.")
    }
  } else {
    file.copy(files_to_backup_from, files_to_backup_to, overwrite = TRUE)
  }

}
