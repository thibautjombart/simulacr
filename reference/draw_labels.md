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
#> [1] "SPcKOY"
draw_labels(10, 3)
#>  [1] "taX" "tTg" "8OJ" "HeE" "m6W" "x4K" "Ass" "o3z" "O6d" "AoE"
```
