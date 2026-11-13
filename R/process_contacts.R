#' Check/process input of contacts
#' 
#' Internal function to process contacts between individuals. 
#' 
#' @param x Contacts between all individuals in the population. It can
#'    be specified in two ways: i) an n x n matrix where entries correspond to
#'    contact presence or intensities, or ii) a function with a single argument
#'    `t` (time step) generating such matrix at each time step. If `NULL`
#'    (default), we assume random-mixing in the population, i.e. all individuals
#'    are in contact at every time step.
#'   
#' @param n An `integer` indicating the number of individuals in the population.
#' 
#' @param duration An `integer` indicating the number of time steps to run the
#'   simulation for; defaults to 1L (i.e. only the initial infection is
#'   generated).
#'   
#' @returns a function of time (t) returning a contact matrix
#'
#' @author Thibaut Jombart

process_contacts <- function(x, n, duration) {
  if (is.null(x)) stop("contacts is NULL")
  
  if (is.matrix(x)) {
    diag(x) <- 0
    if (nrow(x) != n || ncol(x) != n) stop("contacts dimension must be n x n")
    if (!is.numeric(x)) stop("contacts must be numeric")
    if (any(!is.finite(x))) stop("contacts has non-finite entries")
    if (any(x < 0)) stop("contacts has entries < 0")
    return(function(t) x)
  }
  
  if (is.function(x)) {
    arguments <- as.list(args(x))
    arguments <- arguments[!vapply(arguments, is.null, logical(1))] # need to remove the last `NULL`
    
    if (length(arguments) > 1) {
      msg <- "if `contacts` is a function, it should accept a single argument (t)"
      stop(msg)
    }
    
    ## check that the matrix is correct on the first time step
    C_1 <- x(1)
    if (is.null(C_1)) stop("contacts(1) is NULL")
    if (nrow(C_1) != n || ncol(C_1) != n) stop("contacts(1) dimension must be n x n")
    if (!is.numeric(C_1)) stop("contacts(1) must be numeric")
    if (any(!is.finite(C_1))) stop("contacts(1) has non-finite entries")
    if (any(C_1 < 0)) stop("contacts(1) has entries < 0")

    ## check that the matrix is correct on the last time step
    C_end <- x(duration)
    if (is.null(C_end)) stop("contacts(duration) is NULL")
    if (nrow(C_end) != n || ncol(C_end) != n) stop("contacts(duration) dimension must be n x n")
    if (!is.numeric(C_end)) stop("contacts(duration) must be numeric")
    if (any(!is.finite(C_end))) stop("contacts(duration) has non-finite entries")
    if (any(C_end < 0)) stop("contacts(duration) has entries < 0")
    
    return(x)
  }
 
  stop("contacts is not a matrix nor function")
}