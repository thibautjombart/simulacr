# Check/process input of contacts

Internal function to process contacts between individuals.

## Usage

``` r
process_contacts(x, n, duration)
```

## Arguments

- x:

  Contacts between all individuals in the population. It can be
  specified in two ways: i) an n x n matrix where entries correspond to
  contact presence or intensities, or ii) a function with a single
  argument `t` (time step) generating such matrix at each time step. If
  `NULL` (default), we assume random-mixing in the population, i.e. all
  individuals are in contact at every time step.

- n:

  An `integer` indicating the number of individuals in the population.

- duration:

  An `integer` indicating the number of time steps to run the simulation
  for; defaults to 1L (i.e. only the initial infection is generated).

## Value

a function of time (t) returning a contact matrix

## Author

Thibaut Jombart
