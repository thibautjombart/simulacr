# Create a panmictic contact matrix

This function creates a contact matrix for a panmictic (i.e.
random-mixing) population, where every individual is in contact with
every other individual.

## Usage

``` r
make_panmictic_contacts(n)
```

## Arguments

- n:

  An `integer` indicating the number of individuals in the population.

## Value

An n x n matrix of contacts indicated as presence (1) or absence (0) ;
sources are in rows, recipients in column.

## Author

Thibaut Jombart

## Examples

``` r
make_panmictic_contacts(5)
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    0    1    1    1    1
#> [2,]    1    0    1    1    1
#> [3,]    1    1    0    1    1
#> [4,]    1    1    1    0    1
#> [5,]    1    1    1    1    0
```
