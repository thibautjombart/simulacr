# Introduction to simulacr

``` r

library(simulacr)
```

## What does it do?

*simulacr* implements outbreak simulation using contact-driven branching
processes. The main features of the package include:

- [`simulate_outbreak()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak.md):
  the main function, simulating epidemic spread using inputs on the
  generation time distribution, individual transmission rates, and
  contact matrices; it outputs a `simulacr` object, which is a list
  containing a linelist and a transmission tree, which can be converted
  to `epicontacts` objects for visualisation, and plotted using
  `plot(...)`

- [`simulate_outbreak_step()`](https://thibautjombart.github.io/simulacr/reference/simulate_outbreak_step.md):
  the step-wise version of the simulator, designed for calling from
  other packages

- [`make_pmf_delay()`](https://thibautjombart.github.io/simulacr/reference/make_pmf_delay.md):
  to generate probability mass functions of delays distributions

- [`make_disc_gamma()`](https://thibautjombart.github.io/simulacr/reference/make_disc_gamma.md):
  to build discretised Gamma distributions for delay distributions

- [`make_panmictic_contacts()`](https://thibautjombart.github.io/simulacr/reference/make_panmictic_contacts.md):
  to generate a contact matrix assuming random mixing

- [`draw_labels()`](https://thibautjombart.github.io/simulacr/reference/draw_labels.md):
  wrapper function to generate random alphanumeric labels

  

## Worked example

This brief example illustrates how we can simulate an outbreak.

``` r


## make a generation time distribution
gen_time <- make_pmf_delay(make_disc_gamma(10, 7))
plot(
  gen_time(0:30), type = "h", lend = 2, lwd = 10, 
  main = "Generation time distribution", 
  xlab = "Delay from primary to secondary infection (days)", 
  ylab = "p(delay)"
)
```

![](Introduction_files/figure-html/unnamed-chunk-2-1.png)

``` r


## simulate an outbreak using random mixing 
## (no contacts matrix provided -> all individuals are in contact by default)
set.seed(1)
res <- simulate_outbreak(
  n = 100, # 100 individuals in the population
  duration = 365, # simulate for a year
  w = gen_time, # generation time distribution
  tau = runif(100, 0.01, 0.05) # individual transmission rates, from 0.01 to 0.05
)

names(res)
#> [1] "linelist" "tree"
res
#> $linelist
#> # A tibble: 100 × 3
#>    id     casedef date_infection
#>    <chr>  <chr>            <dbl>
#>  1 eLGzdD case                 1
#>  2 8Tvbyj case                40
#>  3 MQ90i6 case                33
#>  4 RdzUUA case                25
#>  5 kSVCEa case                45
#>  6 Z42dvb case                32
#>  7 YWzVgb case                44
#>  8 EGjSAk case                31
#>  9 6rcYKS case                52
#> 10 VBW4HD case                51
#> # ℹ 90 more rows
#> 
#> $tree
#> # A tibble: 96 × 3
#>    from   to      date
#>    <chr>  <chr>  <dbl>
#>  1 NA     eLGzdD     1
#>  2 eLGzdD LjuhEd    13
#>  3 LjuhEd HmhA3k    17
#>  4 LjuhEd J98DE8    22
#>  5 HmhA3k Lwe2aP    22
#>  6 LjuhEd MOZ5Ca    22
#>  7 MOZ5Ca yKVg67    24
#>  8 HmhA3k knhTUJ    24
#>  9 J98DE8 3eZzb4    24
#> 10 Lwe2aP RdzUUA    25
#> # ℹ 86 more rows
#> 
#> attr(,"class")
#> [1] "simulacr" "list"
plot(res)
```
