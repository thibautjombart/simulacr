#' Accessors for simulacr objects
#' 
#' These functions can be used to access the content of `simulacr` objects as 
#' returned by [simulate_outbreak()]. These are all set up as S3 generics with
#' methods for `simulacr` objects.
#' 
#' @author Thibaut Jombart
#' 
#' @param x A `simulacr` object
#' 
#' @param ... Further arguments to be passed to other methods.
#' 
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



