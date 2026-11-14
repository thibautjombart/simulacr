#' Simulate epidemic spread for one time step
#' 
#' Simulated epidemic spread for a single time step. This function is documented
#' so it can be used by other packages. However, it is not intended for direct
#' use by users. Please refer to `[simulated_outbreak()]` for the user-facing
#' version. If you are using this function as part of a separate package, pay
#' attention to inputs as they are not validated. This functions is intended
#' to be used inside a for loop, with input validation being done beforehand.
#' 
#' @export
#' 
#' @author Thibaut Jombart
#' 
#' @param t A single `integer` indicating the current time step. The function
#'   will return the state of the epidemic at time `t + 1`.
#' 
#' @param labels A character vector of length `n` containing the labels of the
#'   individuals.
#'
#' @param S A logical vector of length `n` indicating which
#'   individuals are susceptible.
#' 
#' @param I A logical vector of length `n` indicating which individuals
#'   are infectious.
#'   
#' @param date_infection An `integer` vector of length `n` indicating the dates 
#'   of infection of infected individuals. Entries for non-infected individuals
#'   should be -1 by convention.
#'   
#' @param C A matrix of size `n x n` containing the number of contacts or
#'   contact intensity between individuals at time `t`.
#' 
#' @param tau A numeric vector of length `n` containing individual transmission
#'   rates.
#' 
#' @param w A function calculating the probability mass function of the
#'   generation time distribution for given time intervals, as produced by
#'   `make_pmf_delay`.
#'   
#' @returns A list with the following items:
#' 
#' - `$S`: same as input, updated.
#' - `$I`: same as input, updated.   
#' - `$date_infection`: same as input, updated.
#' - `$tree`: a 3-columns `data.frame` with columns `from`, `to`, and `date` 
#'   reporting new transmission events which took place at time `t+1`
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

simulate_outbreak_step <- function(
    t,
    labels,
    S, 
    I, 
    date_infection, 
    C, 
    tau,
    w
) {
  
  ## store the population size
  n <- length(labels)
  
  ## Determine who is newly infected
  ##
  ## Note: the first term is a vector; every column of C is multiplied by it 
  ## The sum by row is the total FOI coming from i
  ## The sum by column is the total FOI experienced by j
  lambda_t_ij <- (as.numeric(I) * tau * w(t - date_infection)) * C
  rate_infected <- as.numeric(S) * colSums(lambda_t_ij)
  p_infected <- 1 - exp(-rate_infected)
  new_infected <- stats::runif(n) <= p_infected
  
  ## Determine new infectors for each new infected case
  ##
  ## For each new case 'j', the proba of 'i' being the infector are given by
  ## the terms of lambda_t_ij. 
  
  new_infector_lab <- vapply(
    which(new_infected), 
    function(j) sample(
      labels, 
      size = 1, 
      prob = lambda_t_ij[, j]), 
    character(1)
  )
  
  ## Shape the output
  ##
  ## It is a list of updated inputs and some transmission pairs
  out_I <- I | new_infected
  out_S <- S & !new_infected
  out_date_infection <- date_infection
  out_date_infection[new_infected] <- t
  out_tree <- data.frame(
    from = new_infector_lab, 
    to = labels[new_infected],
    date = rep(t, sum(new_infected))
  )
  
  list(
    S = out_S,
    I = out_I,
    date_infection = out_date_infection,
    tree = out_tree
  )
}
