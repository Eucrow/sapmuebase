% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/importRIMLengths.R
\name{importRIMLengths}
\alias{importRIMLengths}
\alias{importLengths}
\title{Import SIRENO lengths report from at-market sampling in the ICES project.}
\usage{
importRIMLengths(file, path = getwd())
}
\arguments{
\item{file}{vector with the file names.}

\item{path}{path of the files. The working directory by default.}
}
\value{
Return data frame.
}
\description{
This function import the catches files obtained from 'muestreos tallas por up'
reports in SIRENO of ICES project.
}
\details{
Multiple files can be imported at the same time.

To allow a better use of this data in R, fields 'DIA', 'MES', 'YEAR' and
'TRIMESTRE' are created in the returned data frame.
}
