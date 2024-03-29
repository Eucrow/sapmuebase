% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkStructureFile.R
\name{checkStructureFile}
\alias{checkStructureFile}
\title{Check the correct structure file of tallas_x_up SIRENO reports.}
\usage{
checkStructureFile(df, file_type)
}
\arguments{
\item{df}{df to check.}

\item{file_type}{Type of df: "CATCHES", "CATCHES_IN_LENGTHS", "LENGTHS",
"OAB_TRIPS", "OAB_HAULS", "OAB_CATCHES" or "OAB_LENGTHS".}
}
\value{
Two possible errors: 'The dataframe doesn't have the appropriate column names'
or 'The data frame doesn't have the appropriate number of columns'. In case the
structure is correct, doesn't return anything.
}
\description{
Compare the correct number and name of the variables of a df with the structure
in 'formato_variables' dataset in order to check the appropiate format.
}
\details{
WARNING: the dataframe must be obtained from a read.table, read.csv or similar
{base} function. I'ts not available to use after the import with
importRIMCatches(), importRIMLengths(), importRIMCatchesInLengths()...

This function is called inside import SIRENO files functions like
importRIMCatches(), importRIMLengths()...
}
