# Simulate outbreaks with transmission trees

This function implements an individual-based outbreak simulator which
generates transmission trees. A Poisson branching process is used to
generate new cases in time, using the distribution of the reproduction
number (R) and of the duration of the infectious period to determine
rates of infection. A density-dependence term is used so that individual
infectiousness decreases with the proportion of susceptible individuals
in the population (see details). For each simulated case, the simulator
generates an individual reproduction number, date of infection, symptom
onset, and reporting using user-specified distributions. Distributions
can be provided either as `distcrete` objects, as functions computing
the probability mass functions (PMF), or as vectors of numbers taken as
the PMF for values on 0, 1, ..., `length(input) - 1`

## Usage

``` r
simulate_outbreak(
  duration = 100,
  population_size = 100,
  R_values,
  dist_incubation,
  dist_infectious_period,
  dist_reporting = NULL
)
```

## Arguments

- duration:

  the number of days to run the simulation for

- population_size:

  the number of susceptible hosts to use in the simulation; defaults to
  100

- R_values:

  a vector of values to be used as reproduction number; values will be
  drawn at random from this vector to determine the expected numbero of
  secondary cases for each new case

- dist_incubation:

  the distribution of the incubation period, i.e. the time interval
  between infection and onset of symtpoms

- dist_infectious_period:

  the distribution of the infectious period, i.e. the time interval
  between the moment a case starts showing symptoms (onset) and the
  moment they infect new secondary cases

- dist_reporting:

  (optional) the distribution of the reporting delay, i.e. the time
  interval between symptom onset and the date at which the case is
  notified; if `NULL` (default) reporting dates will not be simulated

## Details

Individual infectiousness is determined as \\R x w(t - t\_{onset})\\
where \\R\\ is the individual reproduction number, \\w\\ is the PMF of
the duration of the infectious period, \\t\\ is current time, and
\\t\_{onset}\\ is the date of symptom onset for the considered
individual. The number of new cases at time *t* is then taken from a
Poisson distribution with a rate of infection \\\lambda_t n_s / n\\
where \\lambda_t\\ is the sum of all individual infectiousness at time
*t*, \\n_s\\ is the number of susceptible individuals in the population,
and *n* is the total population size.

## Author

Thibaut Jombart <thibautjombart@gmail.com>

## Examples

``` r

## make toy distributions (showing the 3 possible input types)
incubation <- c(0, 1, 1, 1, 1) # numbers = unscaled PMF
infectious_period <- make_disc_gamma(10, 7) # distcrete object
reporting <- function(x) dpois(x, 5) # PMF function

set.seed(1)
```
