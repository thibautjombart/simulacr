# Animate epidemic spread

Draw one igraph plot per requested time, keeping all individuals in
fixed positions. Case colours and edges reflect the displayed time.

## Usage

``` r
animate_outbreak(x, t, ...)
```

## Arguments

- x:

  A `simulacr` object returned by
  [`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).

- t:

  A non-empty vector of non-negative integer time steps.

- ...:

  Further plotting arguments. A supplied `layout` function is evaluated
  once. The method is fixed to "igraph" and `cases_only` to FALSE.

## Value

The complete `igraph` object with its fixed layout, invisibly.

## Examples

``` r
res <- simulate_outbreak(n = 30, duration = 100, tau = 0.1)
animate_outbreak(res, t = c(1, 5, 10))


```
