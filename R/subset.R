#' Subsetting simulacr objects
#' 
#' This method allows you to subset a simulacr object by retaining specified
#' individuals, data from a select time frame, cases or non-cases. When several
#' selection criteria are used, only individuals fulfilling all criteria are
#' kept. Subsetting is done on the linelist first, and edges are trimmed to
#' remove transmission pairs involving individuals not listed in the linelist.
#' 
#' @export
#' 
#' @author Thibaut Jombart
#' 
#' @param x A `simulacr` object as returned by [simulate_outbreak()].
#' 
#' @param id A vector of `logical`, `integer`, or `character` indicating the 
#'   subset of individuals identifiers to select. Recycled as needed. Defaults 
#'   to `TRUE`, in which case all individuals are kept.
#'   
#' @param start_date A single `integer` indicating the minimum date (inclusive)
#'   of infection for  individuals to be retained. Note that all non-infected 
#'   individuals have a date of infection of -1.
#'   
#' @param end_date A single `integer` indicating the maximum date (inclusive)
#'   of infection for individuals to be retained. Note that all non-infected 
#'   individuals have a date of infection of -1.
#'   
#' @param casedef A `character` vector listing all case definition (normally
#'   `case` or `non_case`) to be retained.
#'   
#' @param ... further arguments to be passed to other methods (for compatibility
#'   with the `subset` generic)

subset.simulacr <- function(x, 
                            id = TRUE, 
                            start_date = NULL, 
                            end_date = NULL, 
                            casedef = c("case", "non_case"), 
                            ...) {
  out <- x
  
  ## we first subset individuals from the linelist sequentially, then subset the
  ## edges so that all IDs are documented in the linelist
  ids <- get_id(x)
  names(ids) <- ids
  kept_ids <- ids[id]
  out$linelist <- out$linelist[ids %in% kept_ids, , drop = FALSE]
  
  if (!is.null(start_date)) {
    to_keep <- get_date_infection(out) >= start_date
    out$linelist <- out$linelist[to_keep, , drop = FALSE]
  }
  
  if (!is.null(end_date)) {
    to_keep <- get_date_infection(out) <= end_date
    out$linelist <- out$linelist[to_keep, , drop = FALSE]
  }
  
  to_keep <- get_casedef(out) %in% casedef
  out$linelist <- out$linelist[to_keep, , drop = FALSE]
  
  
  ## trim edges as needed ; the initial NA of the initial case is ignored
  current_ids <- get_id(out)
  from_to_keep <- out$tree$from %in% current_ids
  NA_posi <- is.na(out$tree$from)
  from_to_keep[NA_posi] <- TRUE # ignore the all NAs (imported cases)
  to_to_keep <- out$tree$to %in% current_ids
  to_keep <- from_to_keep & to_to_keep
  out$tree <- out$tree[to_keep, , drop = FALSE]
  
  out
}