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
#'   subset of cases for which subtrees should be returned. If empty, subtrees 
#'   of all cases are returned.
#'   
#' @param include_empty A `logical` indicating of empty subtrees should be
#'   returned; FALSE by default.
#' 
#' @returns A named list of IDs forming descending subtrees from cases.
#' 
#' @examples
#' set.seed(123)
#' x <- simulate_outbreak(50, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))
#' plot(x)
#' subtree(x) # all subtrees
#' subtree(x, get_id(subset(x, casedef = "case"))[1:3]) # trees of first 3 cases
#' subtree(x, include_empty = TRUE) # show empty subtrees

subtree <- function(x, ids, include_empty = FALSE) {
  if (!inherits(x, "simulacr")) {
    stop("x should be a simulacr object")
  }
  if (missing(ids)) {
    ids <- get_id(subset(x, casedef = "case"))
  }
  if (!(is.logical(ids) || is.numeric(ids) || is.character(ids))) {
    stop("ids should be a logical, integer, or character vector")
  }
  id_cases <- get_id(subset(x, casedef = "case"))
  if (is.character(ids) && !all(ids %in% id_cases)) {
    stop("some ids are not listed cases in x")
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
    tree <- lab[is.finite(d)]
    setdiff(tree, id) # remove the node itself from the descending tree
  }
  
  
  out <- lapply(ids, list_descendants)
  names(out) <- ids
  
  if (!include_empty) {
    out <- out[sapply(out, length) > 0]
  }
  out
}