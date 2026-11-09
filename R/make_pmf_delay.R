#' Create a probability mass function.
#'
#' This function can turn various inputs into a probability mass function 
#' defined for non-negative integers. See argument 'x' for details.
#' 
#' @param x The sole input of the function, which can be any of 3 types: i) a
#'   `distcrete` object ii) a function returning a PMF (e.g. `dpois`), or iii) a
#'   vector of positive numbers taken as a probability mass function (pmf) on 0,
#'   1, 2, ..., `(length(x) - 1)`, in which case it is standardised to sum to 1.
#' 
#' @author Thibaut Jombart
#' 
#' @export
#' 
#' @examples
#' ## create a pmf from a distcrete object
#' d <- distcrete::distcrete("exp", rate = 3.123, w = 0, interval = 1)
#' res <- make_pmf_delay(d)
#' res(0:10)
#' 
#' ## create a pmf from a function
#' res <- make_pmf_delay(function(x) dpois(x, lambda = 1.198))
#' res(0:10)
#' 
#' ## create a pmf from a vector of positive numbers
#' res <- make_pmf_delay(c(1:5, 10:1))
#' res(0:20)
#' res(-1)
#' 

make_pmf_delay <- function(x) {

  ## check input type ; oddly enough integer vectors don't inherit 'numeric', 
  ## but their is.numeric() is TRUE
  if (!inherits(x, c("distcrete", "function", "numeric")) && !is.numeric(x)) {
    msg <- "'x' must be a distcrete object, a function, or a numeric vector"
    stop(msg)
  }
  
  
  ## handle `x` input as distcrete object
  if (inherits(x, "distcrete")) {
    return(x$d)
  }
  
  
  ## handle `x` input as function returning pmf values ; we check that the
  ## function has as single argument, and also produces only positive, finite
  ## numbers on a test input going from 0:100
  if (is.function(x)) {
    arguments <- as.list(args(x))
    arguments <- arguments[!vapply(arguments, is.null, logical(1))] # need to remove the last `NULL`
    
    if (length(arguments) > 1) {
      msg <- "if `x` is a function, it should accept a single argument"
      stop(msg)
    }
    
    test_values <- 0:100
    test_results <- x(test_values)
    
    if (length(test_results) != length(test_values)) {
      msg <- sprintf(
        "test code `x(0:100)` produces output with wrong length (expected: %d found: %d)",
        length(test_values),
        length(test_results))
      stop(msg)
    }
    
    if (any(!is.finite(test_results))) {
      msg <- "test code `x(0:100)` produces some non-finite numbers"          
      stop(msg)
    }
    
    if (any(test_results < 0)) {
      msg <- "test code `x(0:100)` produces some negative numbers"
      stop(msg)
    }
    
    return(x)
  }

  ## handle `x` input as a vector of numeric values
  ## we check that the input is numeric, has only finite and positive values
  if (any(!is.finite(x))) {
    msg <- "some values in 'x' are not finite"
    stop(msg)
  }

  if (any(x < 0)) {
    msg <- "some values in 'x' are negative"
    stop(msg)
  }

  ## standardise the values and generate a function
  pmf <- x / sum(x)
  pool <- as.integer(seq_along(pmf) - 1L)
  
  function(x) {
    x <- as.integer(x)
    out <- double(length(x))  
    p_not_zero <- (x >= 0) & (x <= max(pool))
    out[p_not_zero] <- pmf[x[p_not_zero] + 1]
    out
  }
}
