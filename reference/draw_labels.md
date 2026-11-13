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
#> [1] "5pb90S"
draw_labels(10, 3)
#>  [1] "UHj" "lsA" "2JO" "CP3" "OyH" "gjC" "yj3" "Whg" "1DI" "dTQ"
```
