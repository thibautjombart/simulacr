#' Convert simulacr objects to epicontacts
#'
#' The function `as_epicontacts` is a generic with a method for `simulacr` 
#' objects as returned by [simulate_outbreak()].
#'
#' @author Thibaut Jombart, Cyril Geismar
#'
#' @export
#' 
#' @rdname as_epicontacts
#'
#' @param x A `simulacr` object returned by [simulate_outbreak()].
#' 
#' @param cases_only A `logical` indicating if cases only should be included in
#'   the converted object; defaults to `FALSE`.
#'   
#' @param ... Further arguments to be passed to other methods.
#'
#' @examples
#' 
#' ## simulate an outbreak
#' x <- simulate_outbreak(
#'   n = 100, duration = 50, tau = 0.3, 
#'   contacts = make_random_contacts(100, 5)
#' )
#' 
#' ## conversions to epicontacts and igraph
#' as_epicontacts(x)
as_epicontacts <- function(...) {
  UseMethod("as_epicontacts")
}



#' @rdname as_epicontacts
#' @export
#' 
as_epicontacts.simulacr <- function(x, cases_only = FALSE, ...) {
  if (cases_only) {
    x <- subset(x, casedef = "case")
  }
  epicontacts::make_epicontacts(
    linelist = x$linelist,
    contacts = x$tree,
    directed = TRUE
  )
}