% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_disc_gamma.R
\name{make_disc_gamma}
\alias{make_disc_gamma}
\title{Make a discretized gamma distribution}
\usage{
make_disc_gamma(mean, sd)
}
\arguments{
\item{mean}{the mean of the distribution}

\item{sd}{the standard deviation of the distribution}
}
\description{
This function is a simple wrapper around the packages \emph{epitrix} and
\emph{distcrete} allowing to create a discretised Gamma distribution with given
mean and standard deviration, returning a \code{distcrete} object.
}
\examples{

serial_interval <- make_disc_gamma(15, 9)


## check PMF
plot(0:30, serial_interval$d(0:30), type = "h",
     lwd = 3, col = "navy",
     xlab = "Number of days", ylab = "probability",
     main = "Probability mass function")

## simulate random numbers
serial_interval$d(20)

}
\author{
Thibaut Jombart
}
