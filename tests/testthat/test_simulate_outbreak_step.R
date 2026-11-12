## Note: this function being internal, it is not meant to test its inputs
## Therefore all tests here aim to check that results are correct, but no
## error checking is done.

test_that(
  "simulate_outbreak_step() works as expected", {
    
    ## No infected, no transmission
    labels <- letters[1:10]
    S <- rep(TRUE, 10)
    I <- rep(FALSE, 10)
    date_infection <- as.integer(rep(-1L, 10))
    C <- matrix(sample(0:1, 100, TRUE), 10, 10)
    diag(C) <- 0
    tau <- runif(10)
    w <- make_pmf_delay(c(0, 1, 2, 2.5, 4, 3, 3, 2, 1))
    t <- 1
    
    res <- simulate_outbreak_step(
      t = 1, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    
    expect_equal(sum(res$S), 10)
    expect_equal(sum(res$I), 0)
    expect_true(all(res$date_infection < 0))
    expect_equal(nrow(res$tree), 0L)
    expect_equal(ncol(res$tree), 3L)
    expect_identical(names(res$tree), c("from", "to", "date"))
    
    
  }
)
