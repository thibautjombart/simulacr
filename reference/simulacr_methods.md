# Basic methods for simulacr objects

These functions implement basic methods for simulacr objects as returned
by
[`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).
They include:

- `as_epicontacts`: conversion to `epicontacts` object

- `as.epicontacts`: alias for `as_epicontacts`

- `plot`: interactive or static transmission tree plots

## Usage

``` r
as_epicontacts(...)

as.epicontacts(...)

# S3 method for class 'simulacr'
as_epicontacts(x, ...)

# S3 method for class 'simulacr'
plot(x, method = c("visNetwork", "igraph"), ...)
```

## Arguments

- ...:

  For `plot`, further arguments passed to
  [`epicontacts::plot.epicontacts()`](https://rdrr.io/pkg/epicontacts/man/plot.epicontacts.html)
  or
  [`igraph::plot.igraph()`](https://r.igraph.org/reference/plot.igraph.html).
  For igraph, `rescale = FALSE` and `asp = 0` are fixed.

- x:

  A `simulacr` object returned by
  [`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).

- method:

  A character string indicating the plotting method: `"visNetwork"`
  (default) for an interactive plot, or `"igraph"` for a static tree
  with a time axis.
