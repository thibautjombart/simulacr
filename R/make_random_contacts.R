#' Create a contact matrix according to individual contact rates
#' 
#' This function creates a contact matrix where individuals are allowed to have
#' different contact rates. By default, it returns a number of contacts in a
#' day, drawn from a Poisson distribution, but it can also return the
#' presence/absence of contacts.
#' 
#' @author Thibaut Jombart
#' 
#' @export
#'   
#' @param n A single `integer` indicating the number of individuals in the
#'   population.
#' 
#' @param rate A `numeric` vector on length `n` indicating the daily rate at
#'   which each individual makes contact with other individuals. If provided as
#'   as single number, this will be recycled. Defaults to 0 - no contact.
#'   
#' @param binary_output A `logical` indicating the output should be
#'   presence/absence (TRUE), or numbers of contacts per day (FALSE, default).
#' 
#' @returns An n x n matrix of contacts, either number of contacts (default), 
#'   or as presence/absence of contact (`binary_output = TRUE`). Sources are in
#'   rows, recipients in column.
#'   
#' @examples
#' ## 4 individuals, no contact with rate = 0
#' res <- make_random_contacts(4, 0)
#' res
#' 
#' ## same with higher rate
#' res <- make_random_contacts(4, 2.5)
#' res
#' 
#' ## 6 individuals with some Poisson-distributed heterogeneity in rates,
#' ## average 5.6 contacts per day, except for indiv 2 (rate 500) and 3 
#' ## (rate (0)) 
#' rates <- rpois(6, 5.6)
#' rates[2] <- 500
#' rates[3] <- 0
#' set.seed(1) # only to compare results with next example
#' res <- make_random_contacts(6, rates)
#' res
#' 
#' ## same, binary output (fixing seed for comparable results)
#' res_nb <- res
#' set.seed(1)
#' res <- make_random_contacts(6, rates, TRUE)
#' res_nb
#' res 
#' 
make_random_contacts <- function(n, rate = 0, binary_output = FALSE) {
  n <- process_n(n)

  if (length(rate) == 0L) stop("'rate' has length 0")
  if (length(rate) == 1L) {
    rate <- rep(rate, length.out = n)
  }
  if (!is.numeric(rate)) stop("'rate' should be numeric")
  if (any(!is.finite(rate))) stop("'rate' should be finite")
  if (any(rate < 0)) stop("'rate' should be >= 0")
  if (length(rate) != n) stop("'rate' should have length 'n'")
  
  ## We first draw the total number of contacts made by each individual from a 
  ## Poisson distribution, then sample with replacement (Multinomial) from the
  ## pool of available contacts, avoiding self-contacts. We make an auxiliary 
  ## function for convenience to get contacts from a single individual.
  ## - n: number of contacts to draw
  ## - id: ID of the individual making the contacts
  pool <- seq_len(n)
  draw_contact <- function(n, id) {
    sample(pool[-id], n, replace = TRUE)    
  }
  
  n_contacts <- rpois(n, rate)
  id_have_contacts <- which(n_contacts > 0)
  out <- matrix(0, nrow = n, ncol = n)
  
  for (i in id_have_contacts) {
    contacts_tab <- table(draw_contact(n_contacts[i], i))
    out[i, as.integer(names(contacts_tab))] <- as.numeric(contacts_tab)
  }
  
  if (binary_output) {
    out <- 1* (out > 0)
  }
  
  out
}
