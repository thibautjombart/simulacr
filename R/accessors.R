#' Accessors for simulacr objects
#' 
#' These functions can be used to access the content of `simulacr` objects as 
#' returned by [simulate_outbreak()]. These are all set up as S3 generics with
#' methods for `simulacr` objects. See details for the list of accessors.
#' 
#' @author Thibaut Jombart
#' 
#' @param x A `simulacr` object
#' 
#' @param ... Further arguments to be passed to other methods.
#' 
#' @details
#' The following accessors are available:
#' - `get_n()`: returns the number of individuals (cases or non-cases)
#' - `get_n_cases()`: returns the number of cases
#' - `get_n_non_cases()`: returns the number of non-cases
#' - `get_id()`: returns individual identifiers
#' - `get_date_infection()`: returns the dates of infections (-1 for non-cases)
#' - `get_casedef()`: returns the case definition of all individuals
#' - `get_tree()`: returns the list of transmission pairs
#' - `get_imports()`: returns the labels of imported cases
#' - `get_R()`: returns the case reproduction numbers for each case 
#' 
#' @examples
#' # example code
#' x <- simulate_outbreak(30, 10, tau = 0.05, w = c(0, 1, 1, 2, 1.123, .55))
#' x
#' get_n(x)
#' get_n_cases(x)
#' get_n_non_cases(x)
#' get_id(x)
#' get_date_infection(x)
#' get_tree(x)
#' get_imports(x)
#' get_R(x)


#' @rdname accessors
#' @export
get_n <- function(x, ...) {
  UseMethod("get_n")
}

#' @rdname accessors
#' @export
get_n.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_n.simulacr <- function(x, ...) {
  nrow(x$linelist)
} 





#' @rdname accessors
#' @export
#' @aliases get_n_cases
get_n_cases <- function(x, ...) {
  UseMethod("get_n_cases")
}

#' @rdname accessors
#' @export
get_n_cases.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_n_cases.simulacr <- function(x, ...) {
  sum(x$linelist$casedef == "case", na.rm = TRUE)
} 





#' @rdname accessors
#' @export
#' @aliases get_n_non_cases
get_n_non_cases <- function(x, ...) {
  UseMethod("get_n_non_cases")
}

#' @rdname accessors
#' @export
get_n_non_cases.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_n_non_cases.simulacr <- function(x, ...) {
  sum(x$linelist$casedef == "non_case", na.rm = TRUE)
} 





#' @rdname accessors
#' @export
#' @aliases get_date_infection
get_date_infection <- function(x, ...) {
  UseMethod("get_date_infection")
}

#' @rdname accessors
#' @export
get_date_infection.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_date_infection.simulacr <- function(x, ...) {
  x$linelist$date_infection
} 





#' @rdname accessors
#' @export
#' @aliases get_id
get_id <- function(x, ...) {
  UseMethod("get_id")
}

#' @rdname accessors
#' @export
get_id.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_id.simulacr <- function(x, ...) {
  x$linelist$id
} 





#' @rdname accessors
#' @export
#' @aliases get_tree
get_tree <- function(x, ...) {
  UseMethod("get_tree")
}

#' @rdname accessors
#' @export
get_tree.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_tree.simulacr <- function(x, ...) {
  x$tree[, c("from", "to"), drop = FALSE]
} 





#' @rdname accessors
#' @export
#' @aliases get_casedef
get_casedef <- function(x, ...) {
  UseMethod("get_casedef")
}

#' @rdname accessors
#' @export
get_casedef.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_casedef.simulacr <- function(x, ...) {
  x$linelist$casedef
} 





#' @rdname accessors
#' @export
#' @aliases get_imports
get_imports <- function(x, ...) {
  UseMethod("get_imports")
}

#' @rdname accessors
#' @export
get_imports.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_imports.simulacr <- function(x, ...) {
  as.vector(x$tree$to[is.na(x$tree$from)])
} 





#' @rdname accessors
#' @export
#' @aliases get_R
get_R <- function(x, ...) {
  UseMethod("get_R")
}

#' @rdname accessors
#' @export
get_R.default <- function(x, ...) {
  msg <- paste("No method for object of class", class(x)[1])
  stop(msg)
} 

#' @rdname accessors
#' @export
get_R.simulacr <- function(x, ...) {
  x <- subset(x, casedef = "case")
  vapply(
    get_id(x), 
    function(id) sum(id == get_tree(x)$from, na.rm = TRUE), 
    integer(1)
  )
} 




