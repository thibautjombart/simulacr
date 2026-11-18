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
#>   // 100 cases in linelist; 50 contacts;  directed 
#> 
#>   // linelist
#> 
#> # A tibble: 100 × 3
#>    id     casedef  date_infection
#>    <chr>  <chr>             <dbl>
#>  1 IrBoMF case                  1
#>  2 r8nMx7 non_case             -1
#>  3 SWp22n non_case             -1
#>  4 C4r4Qy case                  6
#>  5 ZkFcAR case                  6
#>  6 A7MwsG case                  4
#>  7 e7JcRh case                  5
#>  8 t6dqMc case                  5
#>  9 SAV8e9 case                  3
#> 10 V5V2pH case                 12
#> # ℹ 90 more rows
#> 
#>   // contacts
#> 
#> # A tibble: 50 × 3
#>    from   to      date
#>    <chr>  <chr>  <dbl>
#>  1 NA     IrBoMF     1
#>  2 IrBoMF 7gJoXw     2
#>  3 IrBoMF X5MxwR     2
#>  4 X5MxwR SAV8e9     3
#>  5 7gJoXw MesjP9     3
#>  6 7gJoXw lGyB1b     3
#>  7 MesjP9 A7MwsG     4
#>  8 lGyB1b svQULF     4
#>  9 lGyB1b 2e4QlI     4
#> 10 lGyB1b 8NdzMK     4
#> # ℹ 40 more rows
#> 
```
