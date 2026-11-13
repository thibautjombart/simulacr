# Basic methods for simulacr objects

These functions implement basic methods for simulacr objects as returned
by
[`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).
They include:

- `as_epicontacts`: conversion to `epicontacts` object

- `as.epicontacts`: alias for `as_epicontacts`

## Usage

``` r
as_epicontacts(...)

as.epicontacts(...)

# S3 method for class 'simulacr'
as_epicontacts(x, ...)

# S3 method for class 'simulacr'
plot(x, ...)
```

## Arguments

- ...:

  for `plot`, arguments passed to `plot.epicontacts` in the
  `epicontacts` package.

- x:

  an object to be converted to `epicontacts`
