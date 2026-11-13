#' Check/process input of population size
#' 
#' Internal function to process the population size `n`. 
#'   
#' @param x An `integer` indicating the number of individuals in the population.
#'   
#' @returns its argument, possibly modified
#'
#' @author Thibaut Jombart

process_n <- function(x) {
  if (!is.numeric(x)) stop("n must be numeric")
  if (!is.finite(x)) stop("n must be finite")
  if (x < 1) stop("n must be >= 1")
  as.integer(x)
}