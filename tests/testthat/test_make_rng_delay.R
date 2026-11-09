test_that(
  "make_rng_delay() issues the correct errors", {
    
    msg <- "'max_delay' must be a single number"
    expect_error(make_rng_delay(1:10, 1:2), msg)
    
    msg <- "'max_delay' must be a finite number"
    expect_error(make_rng_delay(1:10, Inf), msg)
    
    msg <- "'max_delay' must be >= 1"
    expect_error(make_rng_delay(1:10, 0), msg)
    
  }
)




test_that(
  "make_rng_delay() returns correct outputs", {
    
    ## check that distributional properties are correct
    x <- distcrete::distcrete("norm", mean = 12, sd = 1, interval = 1, w = 0.5)
    res <- make_rng_delay(x)
    samp <- res(1e4)
    expect_equal(round(mean(samp)), 12)
    expect_true(sd(samp) > 0.9)
    expect_true(sd(samp) < 1.1)
    
    x <- function(x) dpois(x, 55)
    res <- make_rng_delay(x)
    samp <- res(1e4)
    expect_equal(round(mean(samp)), 55)
    expect_true(var(samp) > 40)
    expect_true(var(samp) < 70)
    
  }
)