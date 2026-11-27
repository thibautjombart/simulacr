# Convert simulacr objects to igraph

The function `as_igraph` is a generic with a method for `simulacr`
objects as returned by
[`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).

## Usage

``` r
as_igraph(...)

# S3 method for class 'simulacr'
as_igraph(x, cases_only = FALSE, ...)
```

## Arguments

- ...:

  Further arguments to be passed to other methods.

- x:

  A `simulacr` object returned by
  [`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).

- cases_only:

  A `logical` indicating if cases only should be included in the
  converted object; defaults to `FALSE`.

## Author

Thibaut Jombart, Cyril Geismar

## Examples

``` r

## simulate an outbreak
x <- simulate_outbreak(
  n = 100, duration = 50, tau = 0.3, 
  contacts = make_random_contacts(100, 5)
)

as_igraph(x)
#> IGRAPH f63ae46 DN-- 100 0 -- 
#> + attr: name (v/c), casedef (v/c), date_infection (v/n), date (e/n)
#> + edges from f63ae46 (vertex names):
```
