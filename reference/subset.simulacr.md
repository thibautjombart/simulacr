# Subsetting simulacr objects

This method allows you to subset a simulacr object by retaining
specified individuals, data from a select time frame, cases or
non-cases. When several selection criteria are used, only individuals
fulfilling all criteria are kept. Subsetting is done on the linelist
first, and edges are trimmed to remove transmission pairs involving
individuals not listed in the linelist.

## Usage

``` r
# S3 method for class 'simulacr'
subset(
  x,
  id = TRUE,
  start_date = NULL,
  end_date = NULL,
  casedef = c("case", "non_case"),
  ...
)
```

## Arguments

- x:

  A `simulacr` object as returned by
  [`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md).

- id:

  A vector of `logical`, `integer`, or `character` indicating the subset
  of individuals identifiers to select. Recycled as needed. Defaults to
  `TRUE`, in which case all individuals are kept.

- start_date:

  A single `integer` indicating the minimum date (inclusive) of
  infection for individuals to be retained. Note that all non-infected
  individuals have a date of infection of -1.

- end_date:

  A single `integer` indicating the maximum date (inclusive) of
  infection for individuals to be retained. Note that all non-infected
  individuals have a date of infection of -1.

- casedef:

  A `character` vector listing all case definition (normally `case` or
  `non_case`) to be retained.

- ...:

  further arguments to be passed to other methods (for compatibility
  with the `subset` generic)

## Author

Thibaut Jombart
