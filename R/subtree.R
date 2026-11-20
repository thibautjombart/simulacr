#' Identify the subtree coming from specific cases
#' 
#' This function returns the transmission tree descending from a given case. If 
#' several cases are provided, one subtree per case is returned.
#' 
#' @author Thibaut Jombart
#' 
#' @export
#' 
#' @param x A `simulacr` object as returned by [simulate_outbreak()].
#' 
#' @param id A vector of `logical`, `integer`, or `character` indicating the 
#'   subset of cases for which subtrees should be returned. No default.
#'   
#' @param include_empty A `logical` indicating of empty subtrees should be
#'   returned; FALSE by default.
#' 
subtree <- function(x, ids, include_empty = FALSE) {
  if (!inherits(x, "simulacr")) {
    stop("x should be a simulacr object")
  }
  if (!(is.logical(ids) || is.numeric(ids) || is.character(x))) {
    stop("ids should be a logical, integer, or character vector")
  }
  if (is.character(ids) && !all(ids %in% get_id(x))) {
    stop("some ids are not listed in x")
  }
   
  all_ids <- get_id(x)
  names(all_ids) <- all_ids
  ids <- all_ids[ids]
  
  ## we use igraph::distances from the nodes to know which are part of the same
  ## subtree: non-connected nodes have Inf distance to the parent node
  g <- as_igraph(x)
  lab <- names(igraph::V(g))
  deg <- igraph::degree(g)
  
  list_descendants <- function(id) {
    d <- igraph::distances(g, id, mode = "out")
    lab[is.finite(d)]
  }
  
  
  out <- lapply(ids, list_descendants)
  names(out) <- ids
  
  if (!include_empty) {
    out <- out[sapply(out, length) > 0]
  }
  out
}