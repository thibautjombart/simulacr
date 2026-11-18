#' Convert simulacr objects to igraph
#'
#' The function `as_igraph` is a generic with a method for `simulacr` 
#' objects as returned by [simulate_outbreak()].
#'
#' @author Thibaut Jombart, Cyril Geismar
#'
#' @export
#' 
#' @rdname as_igraph
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
#' as_igraph(x)
as_igraph <- function(...) {
  UseMethod("as_igraph")
}


#' @rdname as_igraph
#' @export
#' 
as_igraph.simulacr <- function(x, cases_only = FALSE, ...) {
  edges <- x$tree[!is.na(x$tree$from), , drop = FALSE]
  if (cases_only) {
    x$linelist <- x$linelist[x$linelist$casedef == "case", , drop = FALSE]
  }
  igraph::graph_from_data_frame(
    d = edges,
    directed = TRUE,
    vertices = x$linelist
  )
}

