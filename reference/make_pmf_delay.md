# Create a probability mass function.

This function can turn various inputs into a probability mass function
defined for non-negative integers. See argument 'x' for details.

## Usage

``` r
make_pmf_delay(x)
```

## Arguments

- x:

  The sole input of the function, which can be any of 3 types: i) a
  `distcrete` object ii) a function returning a PMF (e.g. `dpois`),
  or iii) a vector of positive numbers taken as a probability mass
  function (pmf) on 0, 1, 2, ..., `(length(x) - 1)`, in which case it is
  standardised to sum to 1.

## Author

Thibaut Jombart

## Examples

``` r
## create a pmf from a distcrete object
d <- distcrete::distcrete("exp", rate = 3.123, w = 0, interval = 1)
res <- make_pmf_delay(d)
res(0:10)
#>  [1] 9.559751e-01 4.208670e-02 1.852863e-03 8.157209e-05 3.591203e-06
#>  [6] 1.581023e-07 6.960438e-09 3.064325e-10 1.349065e-11 5.939693e-13
#> [11] 2.609024e-14

## create a pmf from a function
res <- make_pmf_delay(function(x) dpois(x, lambda = 1.198))
res(0:10)
#>  [1] 3.017972e-01 3.615530e-01 2.165703e-01 8.648373e-02 2.590188e-02
#>  [6] 6.206090e-03 1.239149e-03 2.120715e-04 3.175771e-05 4.227305e-06
#> [11] 5.064311e-07

## create a pmf from a vector of positive numbers
res <- make_pmf_delay(c(1:5, 10:1))
res(0:20)
#>  [1] 0.01428571 0.02857143 0.04285714 0.05714286 0.07142857 0.14285714
#>  [7] 0.12857143 0.11428571 0.10000000 0.08571429 0.07142857 0.05714286
#> [13] 0.04285714 0.02857143 0.01428571 0.00000000 0.00000000 0.00000000
#> [19] 0.00000000 0.00000000 0.00000000
res(-1)
#> [1] 0
```
