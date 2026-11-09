test_that(
  "make_pmf() issues the correct errors", {
    
    msg <- "'x' must be a distcrete object, a function, or a numeric vector"
    expect_error(make_pmf(NULL), msg)
    
    msg <- "if `x` is a function, it should accept a single argument"
    expect_error(make_pmf(rnorm), msg)
    
    msg <- "test code `x\\(0:100\\)` produces some negative numbers"
    expect_error(make_pmf(function(n) rnorm(n)), msg)
    
    msg <- "test code `x\\(0:100\\)` produces output with wrong length \\(expected: 101 found: 1\\)"
    expect_error(make_pmf(function(n) 1L), msg)
    
    f <- function(x) suppressWarnings(dpois(0:100, lambda = runif(101, -1, 1)))
    msg <- ""
    expect_error(make_pmf(f), msg)
    
    msg <- "some values in 'x' are negative"
    expect_error(make_pmf(-1:10), msg)
    
    msg <- "some values in 'x' are not finite"
    expect_error(make_pmf(c(1, 0.129, NA)), msg)
    
  }
)




test_that(
  "make_pmf() returns correct outputs", {
    
    ## input is a distcrete: function returns the $d component
    x <- distcrete::distcrete("norm", 1)
    res <- make_pmf(x)
    expect_identical(x$d, res)
    
    ## input is a function returning pmf values
    f <- function(x) dpois(x, 1.132)
    expect_identical(f, make_pmf(f))
    
    ## input is a vector of probabilities
    ## output should standardise values and return 0 outside provided range
    w <- 1:4
    res <- make_pmf(w)
    expect_true(is.function(res))
    expect_equal(res(-1:4), c(0, 0.1, 0.2, 0.3, 0.4, 0))
  }
)