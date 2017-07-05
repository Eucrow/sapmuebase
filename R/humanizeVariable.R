# function to humanize one variable
#' Humanize variable
#
#' Add new column with the description of a variable coded... I mean, of a
#' encoded column create a new one with the appropriate description.
#' It's available for variables with a data source: COD_PUERTO, COD_BARCO,
#' COD_ARTE, COD_ORIGEN, COD_TIPO_MUE, COD_ESP_MUE, COD_ESP_CAT.
#' Before the humanization, checks the correct format of the variable.
#' @param df: df wich contains the variable to humanize
#' @param variable: one of this values: COD_PUERTO, COD_BARCO,
#' COD_ARTE, COD_ORIGEN, COD_TIPO_MUE, COD_ESP_MUE, COD_ESP_CAT
#' @return Return the df dataframe with the new variable added.

# TO DO: Add CODSGPM. In maestro_flota_sireno dataset, one CODSGPM can be in various
# rows.
humanizeVariable <- function(df, variable){

  #check if variable exists in the dataframe
  if(variable %in% colnames(df)){

    variable_data <- variables_to_humanize[variables_to_humanize[["ORIGINAL_VAR"]] %in% variable,]

    # check that there are just one record for the variable to humanize in variables_to_humanize dataset
    if (nrow(variable_data) != 1) {
      stop (paste("There is an error with the", variable, "variable in", df, "dataframe.
                  Check if the variable exists in variables_to_humanize dataset or if
                  there are various records for", variable, "."))
    }

    # check the correct format of the variable
    result <- tryCatch({

      checkFormatVariable(df, variable)

    }, error = function(err){

      stop(err)

    }
    )

    # original_var is the variable argument in the function, but is extracted here
    # from variable_data for a better understanding
    original_var <- as.character(variable_data[["ORIGINAL_VAR"]])
    master_var <- as.character(variable_data[["MASTER_VAR"]])
    humanized_master_var <- as.character(variable_data[["HUMANIZED_MASTER_VAR"]])
    humanized_var <- as.character(variable_data[["HUMANIZED_VAR"]])
    master <- as.character(variable_data[["MASTER"]])

    # this is the dataset to join with the dataframe to humanize
    dataframe_to_join_with <- get(master)[, c(master_var, humanized_master_var)]

    # vector of with original column names (usefull to reorder columns after merge)
    column_names_df <- colnames(df)

    if (humanized_var %in% column_names_df){

      warning(paste(humanized_var, "already exists"))

    } else {

      df <- merge(df, dataframe_to_join_with, by.x = original_var, by.y = master_var, all.x = TRUE )
      # this does not work:
      # df <- left_join(df, dataframe_to_join_with, by = c(original_var, master_var))
      # so we have to change the column order:
      # put new column at the end of the dataframe
      df <- df %>%
        select(one_of(column_names_df), everything())
      # and reorder (remember, the new humanized column is the last one, and the
      # variable to humanize is the first one):

      # index of the variable to humanize (usefull to reorder columns after merge)
      index_variable_to_humanize <- which(column_names_df == original_var)

      df <- df[,c(1:index_variable_to_humanize, ncol(df), (index_variable_to_humanize+2):ncol(df)-1)]

      # change the name of the new column, because in some cases, the final column
      # name is different of the humanized variable in master
      colnames(df)[which(names(df)==humanized_master_var)] <- humanized_var

      return (df)
    }

    } else {

      stop(paste("Variable", variable, "does not exists dataframe"))

    }
  }

