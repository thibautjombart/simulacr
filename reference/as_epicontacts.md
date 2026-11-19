# Convert simulacr objects to epicontacts

The function `as_epicontacts` is a generic with a method for `simulacr`
objects as returned by
[`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).

## Usage

``` r
as_epicontacts(...)

# S3 method for class 'simulacr'
as_epicontacts(x, cases_only = FALSE, ...)
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

## conversions to epicontacts and igraph
as_epicontacts(x)
#> 
#> /// Epidemiological Contacts //
#> 
#>   // class: epicontacts
#>   // 100 cases in linelist; 43 contacts;  directed 
#> 
#>   // linelist
#> 
#> # A tibble: 100 × 3
#>    id     casedef  date_infection
#>    <chr>  <chr>             <dbl>
#>  1 QzjNRN case                  1
#>  2 VeocVY case                  5
#>  3 dYBiBW non_case             -1
#>  4 MtNiw1 non_case             -1
#>  5 1EQOXl non_case             -1
#>  6 FXIYNC non_case             -1
#>  7 GvNOcU non_case             -1
#>  8 mRxvbj non_case             -1
#>  9 cZR1c2 non_case             -1
#> 10 N0DPUg non_case             -1
#> # ℹ 90 more rows
#> 
#>   // contacts
#> 
#> # A tibble: 43 × 3
#>    from   to      date
#>    <chr>  <chr>  <dbl>
#>  1 NA     QzjNRN     1
#>  2 QzjNRN osPvna     2
#>  3 osPvna 9qZcx5     3
#>  4 9qZcx5 QcQbl3     4
#>  5 QcQbl3 VeocVY     5
#>  6 QcQbl3 EY8Kl9     5
#>  7 QcQbl3 jGc9A5     5
#>  8 VeocVY tJ1ukN     6
#>  9 VeocVY nTrsve     6
#> 10 VeocVY UXp7Pq     6
#> # ℹ 33 more rows
#> 
```
