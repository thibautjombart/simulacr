#' Prune subtrees coming from specific cases
#' 
#' This function prunes a `simulacr` object by removing selected cases and all their downstream infections.
#' 
#' @author Thibaut Jombart
#' 
#' @export
#' 
#' @param x A `simulacr` object as returned by [simulate_outbreak()].
#' 
#' @param ids A vector of `logical`, `integer`, or `character` indicating the 
#'   subset of cases for which subtrees should be removed. Defaults to NULL, in 
#'   which case no pruning takes place.
#' 
#' @returns A `simulacr` object.
#' 
#' @examples
#' set.seed(123)
#' x <- simulate_outbreak(50, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))
#' plot(x)
#' subtree(x) # list all subtrees
#' res <- prune(x, "eNMXjD") # prune second largest subtree
#' plot(res)

prune <- function(x, ids = NULL) {
  if (!inherits(x, "simulacr")) {
    stop("x should be a simulacr object")
  }
  if (is.null(ids)) return(x)
  
  all_ids <- get_id(x)
  names(all_ids) <- all_ids
  ids <- all_ids[ids]
  
  ## We need to remove separately the subtrees and individuals who are not cases
  ## as they would otherwise throw an error in 'subtree()'.
 
  ### remove subtrees of cases listed in ids
  ids_cases <- get_id(subset(x, casedef = "case"))
  ids_for_pruning <- intersect(ids_cases, ids)
  trees_to_remove <- subtree(x, ids_for_pruning, include_empty = FALSE)
  
  ids_to_remove <- c(unlist(trees_to_remove), ids)
  to_keep <- setdiff(all_ids, ids_to_remove)
  subset(x, id = to_keep)
  
}