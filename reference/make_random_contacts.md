# Create a contact matrix according to individual contact rates

This function creates a contact matrix where individuals are allowed to
have different contact rates. By default, it returns a number of
contacts in a day, drawn from a Poisson distribution, but it can also
return the presence/absence of contacts.

## Usage

``` r
make_random_contacts(n, rate = 0, binary_output = FALSE)
```

## Arguments

- n:

  A single `integer` indicating the number of individuals in the
  population.

- rate:

  A `numeric` vector on length `n` indicating the daily rate at which
  each individual makes contact with other individuals. If provided as
  as single number, this will be recycled. Defaults to 0 - no contact.

- binary_output:

  A `logical` indicating the output should be presence/absence (TRUE),
  or numbers of contacts per day (FALSE, default).

## Value

An n x n matrix of contacts, either number of contacts (default), or as
presence/absence of contact (`binary_output = TRUE`). Sources are in
rows, recipients in column.

## Author

Thibaut Jombart

## Examples

``` r
## 4 individuals, no contact with rate = 0
res <- make_random_contacts(4, 0)
res
#>      [,1] [,2] [,3] [,4]
#> [1,]    0    0    0    0
#> [2,]    0    0    0    0
#> [3,]    0    0    0    0
#> [4,]    0    0    0    0

## same with higher rate
res <- make_random_contacts(4, 2.5)
res
#>      [,1] [,2] [,3] [,4]
#> [1,]    0    2    1    0
#> [2,]    1    0    3    1
#> [3,]    1    0    0    0
#> [4,]    0    1    0    0

## 6 individuals with some Poisson-distributed heterogeneity in rates,
## average 5.6 contacts per day, except for indiv 2 (rate 500) and 3 
## (rate (0)) 
rates <- rpois(6, 5.6)
rates[2] <- 500
rates[3] <- 0
set.seed(1) # only to compare results with next example
res <- make_random_contacts(6, rates)
res
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,]    0    0    1    3    0    0
#> [2,]  103    0   93   87  101  108
#> [3,]    0    0    0    0    0    0
#> [4,]    1    0    0    0    1    3
#> [5,]    3    1    0    0    0    0
#> [6,]    3    0    2    2    2    0

## same, binary output (fixing seed for comparable results)
res_nb <- res
set.seed(1)
res <- make_random_contacts(6, rates, TRUE)
res_nb
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,]    0    0    1    3    0    0
#> [2,]  103    0   93   87  101  108
#> [3,]    0    0    0    0    0    0
#> [4,]    1    0    0    0    1    3
#> [5,]    3    1    0    0    0    0
#> [6,]    3    0    2    2    2    0
res 
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,]    0    0    1    1    0    0
#> [2,]    1    0    1    1    1    1
#> [3,]    0    0    0    0    0    0
#> [4,]    1    0    0    0    1    1
#> [5,]    1    1    0    0    0    0
#> [6,]    1    0    1    1    1    0
```
