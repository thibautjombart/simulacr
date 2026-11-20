# Genrate random labels

This function is a simple wrapper for `stri_rand_strings` from the
`stringi` package to generate random alphanumeric labels.

## Usage

``` r
draw_labels(n = 1, size = 6)
```

## Arguments

- n:

  the number of labels to generate; defaults to 1

- size:

  the number of characters of the labels; defaults to 6

## Author

Thibaut Jombart

## Examples

``` r

draw_labels()
#> [1] "RnDALO"
draw_labels(10, 3)
#>  [1] "Da6" "m92" "H8u" "asm" "MAU" "O3q" "7yF" "X8M" "1cm" "ioW"
```
