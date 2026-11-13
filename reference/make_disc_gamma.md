# Make a discretized gamma distribution

This function is a simple wrapper around the packages *epitrix* and
*distcrete* allowing to create a discretised Gamma distribution with
given mean and standard deviation, returning a `distcrete` object.

## Usage

``` r
make_disc_gamma(mean, sd)
```

## Arguments

- mean:

  the mean of the distribution

- sd:

  the standard deviation of the distribution

## Author

Thibaut Jombart

## Examples

``` r

serial_interval <- make_disc_gamma(15, 9)


## check PMF
plot(0:30, serial_interval$d(0:30), type = "h",
     lwd = 3, col = "navy",
     xlab = "Number of days", ylab = "probability",
     main = "Probability mass function")


## simulate random numbers
serial_interval$d(20)
#> [1] 0.02707902
```
