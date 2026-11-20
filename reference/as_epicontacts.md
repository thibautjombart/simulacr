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
#>   // 100 cases in linelist; 13 contacts;  directed 
#> 
#>   // linelist
#> 
#> # A tibble: 100 × 3
#>    id     casedef  date_infection
#>    <chr>  <chr>             <dbl>
#>  1 A5uIaY case                  1
#>  2 tIPPg7 non_case             -1
#>  3 8c7rzF non_case             -1
#>  4 K5XOIU non_case             -1
#>  5 StxnDY non_case             -1
#>  6 MrjA2N non_case             -1
#>  7 JsUXp7 non_case             -1
#>  8 Pq9i29 non_case             -1
#>  9 zt9RlY non_case             -1
#> 10 tydjO2 non_case             -1
#> # ℹ 90 more rows
#> 
#>   // contacts
#> 
#> # A tibble: 13 × 3
#>    from   to      date
#>    <chr>  <chr>  <dbl>
#>  1 NA     A5uIaY     1
#>  2 A5uIaY cTtO9a     2
#>  3 cTtO9a JjxW2i     3
#>  4 cTtO9a 6YOeIL     3
#>  5 cTtO9a MhIqUK     3
#>  6 MhIqUK goFf8A     4
#>  7 JjxW2i jq1RHQ     4
#>  8 6YOeIL iQfCcn     4
#>  9 iQfCcn 7WPMMf     5
#> 10 goFf8A PAqN1U     5
#> 11 PAqN1U mQlANn     6
#> 12 mQlANn zD5ryQ     7
#> 13 zD5ryQ tsaJZ0     8
#> 
```
