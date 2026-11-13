# Basic methods for outbreaks objects

These functions implement basic methods for outbreaks objects. They
include:

- `as_epicontacts`: conversion to `epicontacts` object

- `as.epicontacts`: alias for `as_epicontacts`

## Usage

``` r
as_epicontacts(...)

as.epicontacts(...)

# S3 method for class 'outbreak'
as_epicontacts(x, ...)

# S3 method for class 'outbreak'
plot(x, ...)
```

## Arguments

- ...:

  for `plot`, arguments passed to `plot.epicontacts` in the
  `epicontacts` package.

- x:

  an object to be converted to `epicontacts`
