#' Create a panmictic contact matrix
#' 
#' This function creates a contact matrix for a panmictic (i.e. random-mixing)
#' population, where every individual is in contact with every other individual.
#' 
#' @author Thibaut Jombart
#' 
#' @export
#'   
#' @param n An `integer` indicating the number of individuals in the population.
#' 
#' @returns An n x n matrix of contacts indicated as presence (1) or absence (0)
#'   ; sources are in rows, recipients in column.
#' 
#' @examples
#' make_panmictic_contacts(5)
#'
make_panmictic_contacts <- function(n) {
  n <- process_n(n)
  out <- matrix(1, nrow = n, ncol = n)
  diag(out) <- 0
  out
}
