# Check/process input of transmission rates

Internal function to process transmission rates `tau`.

## Usage

``` r
process_tau(x, n)
```

## Arguments

- x:

  A numeric vector of length `n` containing individual transmission
  rates; a single value will be recycled; defaults to 0 (no
  transmission).

- n:

  An `integer` indicating the number of individuals in the population.

## Value

its argument, possibly modified

## Author

Thibaut Jombart
