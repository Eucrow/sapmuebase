% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/importOABHaulsCECAF.R
\name{importOABHaulsCECAF}
\alias{importOABHaulsCECAF}
\title{Import SIRENO haul report from on-board sampling in the CECAF project.}
\usage{
importOABHaulsCECAF(file, path = getwd())
}
\arguments{
\item{file}{vector with the file names.}

\item{path}{path of the files. The working directory by default.}
}
\value{
Return data frame.
}
\description{
This function import the hauls file obtained from OAB
reports in SIRENO of CECAF project. The SIRENO hauls report must be generated
with the option 'only hauls'.
}
\details{
Multiple files can be imported at the same time.
}
\note{
The SIRENO hauls report must be generated with the option 'only hauls'.
}
