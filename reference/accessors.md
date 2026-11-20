# Accessors for simulacr objects

These functions can be used to access the content of `simulacr` objects
as returned by
[`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).
These are all set up as S3 generics with methods for `simulacr` objects.
See details for the list of accessors.

## Usage

``` r
get_n(x, ...)

# Default S3 method
get_n(x, ...)

# S3 method for class 'simulacr'
get_n(x, ...)

get_n_cases(x, ...)

# Default S3 method
get_n_cases(x, ...)

# S3 method for class 'simulacr'
get_n_cases(x, ...)

get_n_non_cases(x, ...)

# Default S3 method
get_n_non_cases(x, ...)

# S3 method for class 'simulacr'
get_n_non_cases(x, ...)

get_date_infection(x, ...)

# Default S3 method
get_date_infection(x, ...)

# S3 method for class 'simulacr'
get_date_infection(x, ...)

get_id(x, ...)

# Default S3 method
get_id(x, ...)

# S3 method for class 'simulacr'
get_id(x, ...)

get_tree(x, ...)

# Default S3 method
get_tree(x, ...)

# S3 method for class 'simulacr'
get_tree(x, ...)

get_casedef(x, ...)

# Default S3 method
get_casedef(x, ...)

# S3 method for class 'simulacr'
get_casedef(x, ...)

get_imports(x, ...)

# Default S3 method
get_imports(x, ...)

# S3 method for class 'simulacr'
get_imports(x, ...)

get_R(x, ...)

# Default S3 method
get_R(x, ...)

# S3 method for class 'simulacr'
get_R(x, ...)
```

## Arguments

- x:

  A `simulacr` object

- ...:

  Further arguments to be passed to other methods.

## Details

The following accessors are available:

- `get_n()`: returns the number of individuals (cases or non-cases)

- `get_n_cases()`: returns the number of cases

- `get_n_non_cases()`: returns the number of non-cases

- `get_id()`: returns individual identifiers

- `get_date_infection()`: returns the dates of infections (-1 for
  non-cases)

- `get_casedef()`: returns the case definition of all individuals

- `get_tree()`: returns the list of transmission pairs

- `get_imports()`: returns the labels of imported cases

- `get_R()`: returns the case reproduction numbers for each case

## Author

Thibaut Jombart

## Examples

``` r
# example code
x <- simulate_outbreak(30, 10, tau = 0.05, w = c(0, 1, 1, 2, 1.123, .55))
x
#> $linelist
#> # A tibble: 30 × 3
#>    id     casedef  date_infection
#>    <chr>  <chr>             <dbl>
#>  1 5pb90S case                  1
#>  2 UHjlsA non_case             -1
#>  3 2JOCP3 non_case             -1
#>  4 OyHgjC non_case             -1
#>  5 yj3Whg non_case             -1
#>  6 1DIdTQ non_case             -1
#>  7 hwBDgU non_case             -1
#>  8 de5llz non_case             -1
#>  9 yOSJAW non_case             -1
#> 10 UmCi4L non_case             -1
#> # ℹ 20 more rows
#> 
#> $tree
#> # A tibble: 1 × 3
#>   from  to      date
#>   <chr> <chr>  <dbl>
#> 1 NA    5pb90S     1
#> 
#> attr(,"class")
#> [1] "simulacr" "list"    
get_n(x)
#> [1] 30
get_n_cases(x)
#> [1] 1
get_n_non_cases(x)
#> [1] 29
get_id(x)
#>  [1] "5pb90S" "UHjlsA" "2JOCP3" "OyHgjC" "yj3Whg" "1DIdTQ" "hwBDgU" "de5llz"
#>  [9] "yOSJAW" "UmCi4L" "pGZKaB" "wXXHRN" "1SO1NY" "rNWbGH" "TvODf3" "z9WqiE"
#> [17] "Xp1Tno" "PDPfVe" "Vphs0t" "zVMmad" "rZFurF" "Ol7CAf" "rvYZgF" "2u4zbA"
#> [25] "u2aEuo" "hDjDSK" "ZFSuyo" "talziD" "IirE0w" "RkfPLj"
get_date_infection(x)
#>  [1]  1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
#> [26] -1 -1 -1 -1 -1
get_tree(x)
#> # A tibble: 1 × 2
#>   from  to    
#>   <chr> <chr> 
#> 1 NA    5pb90S
get_imports(x)
#> [1] "5pb90S"
get_R(x)
#> 5pb90S 
#>      0 
```
