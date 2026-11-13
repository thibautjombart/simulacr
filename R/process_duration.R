#' Check/process input of simulation duration
#' 
#' Internal function to process simulation duration. 
#'   
#' @param x An `integer` indicating the number of time steps to run the
#'   simulation for.
#'   
#' @returns its argument, possibly modified
#'
#' @author Thibaut Jombart

process_duration <- function(x) {
  if (!is.numeric(x)) stop("duration must be numeric")
  if (!is.finite(x)) stop("duration must be finite")
  if (x < 1) stop("duration must be >= 1")
  as.integer(x)
}