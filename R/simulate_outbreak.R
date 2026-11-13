#' Simulate outbreaks with transmission trees
#'
#' This function implements a contact-driven branching process outbreak
#' simulator. Outbreaks start with a single infection in an otherwise fully
#' susceptible population of size `n`on the first time step. New cases are
#' generated at each time step by infectious individuals, with forces of
#' infection depending on the generation time distribution, individual
#' transmission rates, and contacts between individuals. The function returns a
#' linelist including both non-cases and cases, as well as a transmission tree
#' listing all transmission events in the shape of a `data.frame` with columns
#' `from`, `to`, and `date`. This function is user-facing; to use the `simulacr`
#' engine in another package, you may want to use the low-level function
#' `[simulate_outbreak_step()]`.
#' 
#' @export
#' 
#' @author Thibaut Jombart \email{thibautjombart@@gmail.com}
#' 
#' @param n An `integer` indicating the number of individuals in the population;
#'   no default.
#'  
#' @param duration An `integer` indicating the number of time steps to run the
#'   simulation for; defaults to 1L (i.e. only the initial infection is
#'   generated).
#'   
#' @param w The probability mass function of the generation time distribution, 
#'  as produced by `[make_pmf_delay()]`, specified as a numeric vector, a
#'  function, or a `distcrete` object. Defaults to a point mass at 1 (i.e. all
#'  secondary infections take place exactly 1 time step after the primary
#'  infection).
#'
#' @param tau A numeric vector of length `n` containing individual transmission 
#'   rates; a single value will be recycled; defaults to 0 (no transmission).
#'   
#'  @param contacts Contacts between all individuals in the population. It can
#'    be specified in two ways: i) an n x n matrix where entries correspond to
#'    contact presence or intensities, or ii) a function with a single argument
#'    `t` (time step) generating such matrix at each time step. If `NULL`
#'    (default), we assume random-mixing in the population, i.e. all individuals
#'    are in contact at every time step.
#'   
#' @param label_size An `integer` indicating the length of the labels generated
#'   by `[draw_labels()]`, used as unique individual identifiers. Defaults to 6.
#'
#' @details
#' The force of infection (FOI) from individual \eqn{i} to \eqn{j} at time 
#' \eqn{t} is defined as:
#' 
#'  \eqn{\lambda_{t, i \rightarrow j} = I_{t,i} C_{t, i \rightarrow j} \tau_{t,i} w(t - T_i)}
#'  
#' The total FOI experienced by individual  at time  is summed over all possible
#' sources of infection:
#' \eqn{\lambda_{t, \bullet \rightarrow j} = S_{t,j} \sum_i \lambda_{t, i \rightarrow j} }
#' 
#' It follows that individual \eqn{j} becomes infected at time \eqn{t+1}
#' according to a Bernoulli distribution with probability:
#'\eqn{ 1 - e^{-\lambda_{t, \bullet \rightarrow j}} }
#'
#' To keep track of chains of transmission, the infector of \eqn{j}, denoted
#' \eqn{alpha_j}, is drawn from a Multinomial distribution weighted by the
#' respective FOIs directed towards \eqn{j}:
#' \eqn{ \alpha_j \sim \mathcal{M}(1, \lambda_{t, 1 \rightarrow j} / \lambda_{t, \bullet \rightarrow j} ,\lambda_{t, 2 \rightarrow j} / \lambda_{t, \bullet \rightarrow j} , \ldots , \lambda_{t, N \rightarrow j} / \lambda_{t, \bullet \rightarrow j}  ) }
#'
#' @examples
#' 
#' ## make toy distributions (showing the 3 possible input types)
#' incubation <- c(0, 1, 1, 1, 1) # numbers = unscaled PMF
#' infectious_period <- make_disc_gamma(10, 7) # distcrete object
#' reporting <- function(x) dpois(x, 5) # PMF function
#' 
#' set.seed(1)


simulate_outbreak <- function(
    n, 
    duration = 1L,
    w = c(0, 1),
    tau = 0,
    contacts = NULL,
    label_size = 6) {
  
  ## Process/sanitize inputs
  n <- process_n(n)
  duration <- process_duration(duration)
  w <- make_pmf_delay(w)
  tau <- process_tau(tau, n)
   
  ## Initialize the outbreak
  
  ## Run the outbreak
  
  
  ## Shape final output
 
  
  out <- data.frame(out, stringsAsFactors = FALSE)
  class(out) <- c("outbreak", class(out))
  attr(out, "has_contacts") <- FALSE
  out
}

