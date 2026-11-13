# Simulate epidemic spread for one time step

Simulated epidemic spread for a single time step. This function is
documented so it can be used by other packages. However, it is not
intended for direct use by users. Please refer to
`[simulated_outbreak()]` for the user-facing version. If you are using
this function as part of a separate package, pay attention to inputs as
they are not validated. This functions is intended to be used inside a
for loop, with input validation being done beforehand.

## Usage

``` r
simulate_outbreak_step(t, labels, S, I, date_infection, C, tau, w)
```

## Arguments

- t:

  A single `integer` indicating the current time step. The function will
  return the state of the epidemic at time `t + 1`.

- labels:

  A character vector of length `n` containing the labels of the
  individuals.

- S:

  A logical vector of length `n` indicating which individuals are
  susceptible.

- I:

  A logical vector of length `n` indicating which individuals are
  infectious.

- date_infection:

  An `integer` vector of length `n` indicating the dates of infection of
  infected individuals. Entries for non-infected individuals should be
  -1 by convention.

- C:

  A matrix of size `n x n` containing the number of contacts or contact
  intensity between individuals at time `t`.

- tau:

  A numeric vector of length `n` containing individual transmission
  rates.

- w:

  A function calculating the probability mass function of the generation
  time distribution for given time intervals, as produced by
  `make_pmf_delay`.

## Value

A list with the following items:

- `$S`: same as input, updated.

- `$I`: same as input, updated.

- `$date_infection`: same as input, updated.

- `$tree`: a 3-columns `data.frame` with columns `from`, `to`, and
  `date` reporting new transmission events which took place at time
  `t+1`

## Details

The force of infection (FOI) from individual \\i\\ to \\j\\ at time
\\t\\ is defined as:

\\\lambda\_{t, i \rightarrow j} = I\_{t,i} C\_{t, i \rightarrow j}
\tau\_{t,i} w(t - T_i)\\

The total FOI experienced by individual at time is summed over all
possible sources of infection: \\\lambda\_{t, \bullet \rightarrow j} =
S\_{t,j} \sum_i \lambda\_{t, i \rightarrow j} \\

It follows that individual \\j\\ becomes infected at time \\t+1\\
according to a Bernoulli distribution with probability: \\ 1 -
e^{-\lambda\_{t, \bullet \rightarrow j}} \\

To keep track of chains of transmission, the infector of \\j\\, denoted
\\alpha_j\\, is drawn from a Multinomial distribution weighted by the
respective FOIs directed towards \\j\\: \\ \alpha_j \sim \mathcal{M}(1,
\lambda\_{t, 1 \rightarrow j} / \lambda\_{t, \bullet \rightarrow j}
,\lambda\_{t, 2 \rightarrow j} / \lambda\_{t, \bullet \rightarrow j} ,
\ldots , \lambda\_{t, N \rightarrow j} / \lambda\_{t, \bullet
\rightarrow j} ) \\

## Author

Thibaut Jombart
