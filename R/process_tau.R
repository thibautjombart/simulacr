#' Check/process input of transmission rates
#' 
#' Internal function to process transmission rates `tau`. 
#' 
#' @param x A numeric vector of length `n` containing individual transmission 
#'   rates; a single value will be recycled; defaults to 0 (no transmission).
#'   
#' @param n An `integer` indicating the number of individuals in the population.
#'   
#' @returns its argument, possibly modified
#'
#' @author Thibaut Jombart

process_tau <- function(x, n) {
  if (length(x) == 0L) stop("tau has length 0")
  if (length(x) == 1L) tau <- rep(x, n)
  if (!all(is.numeric(x))) stop("tau must be numeric")
  if (!all(is.finite(x))) stop("tau must be finite")
  if (!all(x >= 0)) stop("tau must be >= 0")
  x
}