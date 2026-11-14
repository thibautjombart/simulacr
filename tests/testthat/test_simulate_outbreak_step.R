## Note: this function being internal, it is not meant to test its inputs
## Therefore all tests here aim to check that results are correct, but no
## error checking is done.

test_that(
  "simulate_outbreak_step() works as expected", {
    
    ## No infected, all susceptible: no transmission
    labels <- letters[1:10]
    S <- rep(TRUE, 10)
    I <- rep(FALSE, 10)
    date_infection <- as.integer(rep(-1L, 10))
    C <- matrix(sample(0:1, 100, TRUE), 10, 10)
    diag(C) <- 0
    tau <- runif(10, 10, 100) # high rates
    w <- make_pmf_delay(c(0, 1, 2, 2.5, 4, 3, 3, 2, 1))

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
    
    
    ## Some infected but no susceptibles: no transmission
    S <- rep(FALSE, 10)
    I <- rep(FALSE, 10)
    I[1:3] <- TRUE
    date_infection[1:3] <- c(1, 3, 5)

    res <- simulate_outbreak_step(
      t = 6, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    
    expect_equal(sum(res$S), 0)
    expect_equal(sum(res$I), 3)
    expect_equal(res$date_infection, c(1, 3, 5, rep(-1, 7)))
    expect_equal(nrow(res$tree), 0L)
    expect_equal(ncol(res$tree), 3L)
    expect_identical(names(res$tree), c("from", "to", "date"))
    
    
    ## Some infected, some susceptibles, no contact:
    S <- !I
    C <- matrix(0, 10, 10)
    
    res <- simulate_outbreak_step(
      t = 6, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    
    expect_identical(res$S, S)
    expect_identical(res$I, I)
    expect_equal(res$date_infection, c(1, 3, 5, rep(-1, 7)))
    expect_equal(nrow(res$tree), 0L)
    expect_equal(ncol(res$tree), 3L)
    expect_identical(names(res$tree), c("from", "to", "date"))

    
    ## Initial case with high transmission rates towards specific individuals
    ## should result in immediate transmission (targets: indiv 5, 6, 8)
    S <- c(FALSE, rep(TRUE, 9))
    I <- !S
    date_infection <- c(1, rep(-1L, 9))
    C <- matrix(0, 10, 10)
    C[1, c(5,6,8)] <- 1
    tau <- runif(10, 1e4, 1e5) # very high rates
    w <- make_pmf_delay(c(0, 1, 2, 2.5, 4, 3, 3, 2, 1))
    
    res <- simulate_outbreak_step(
      t = 3, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    
    expect_identical(res$S, !res$I)
    expect_equal(sum(res$I[c(1, 5, 6, 8)]), 4)
    expect_equal(sum(res$I[-c(1, 5, 6, 8)]), 0)
    expect_equal(res$date_infection, c(1, -1, -1, -1, 4, 4, -1, 4, -1, -1))
    expect_equal(nrow(res$tree), 3L)
    expect_equal(ncol(res$tree), 3L)
    expect_identical(names(res$tree), c("from", "to", "date"))
    expect_equal(res$tree$from, rep("a", 3))
    expect_equal(res$tree$to, labels[c(5,6,8)])
    expect_equal(res$tree$date, rep(4, 3))

    
    ## Time-varying infectivity. Here we have 3 infected individuals but
    ## - 1 is no longer infectious
    ## - 3 is not yet infectious
    ## - 4 is infectious towards all individuals
    ## 
    ## The result should be all susceptibles get newly infected by 4
    labels <- letters[1:9]
    I <- rep(FALSE, 9)
    I[c(1,3,4)] <- TRUE
    S <- !I
    date_infection <- rep(-1L, 9)
    date_infection[1] <- 1
    date_infection[3] <- 30
    date_infection[4] <- 25
    C <- matrix(1, 9, 9)
    diag(C) <- 0
    tau <- runif(9, 1e4, 1e5) # very high rates
    w <- make_pmf_delay(c(0, 0, 0, 1, 2, 2.5, 4, 3, 3, 2, 1))
    
    res <- simulate_outbreak_step(
      t = 32, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    
    expect_identical(res$S, !res$I)
    expect_true(all(res$I))
    expect_equal(res$date_infection, c(1, 33, 30, 25, 33, 33, 33, 33, 33))
    expect_equal(nrow(res$tree), 6L)
    expect_equal(ncol(res$tree), 3L)
    expect_identical(names(res$tree), c("from", "to", "date"))
    expect_equal(res$tree$from, rep("d", 6))
    expect_equal(res$tree$to, labels[-c(1,3,4)])
    expect_equal(res$tree$date, rep(33, 6))
   
    
    ## Differences in infectiousness make some cases more often infectors than
    ## others
    ##
    ## - 1 and 2 are infected with same dates of infection
    ## - uniform contacts
    ## - 1 is 2x more infectious -> should be infector more often
    labels <- as.character(1:1000)
    I <- rep(FALSE, 1000)
    I[1:2] <- TRUE
    S <- !I
    date_infection <- rep(-1L, 1000)
    date_infection[1:2] <- 1
    C <- matrix(1, 1000, 1000)
    diag(C) <- 0
    tau <- rep(1e4, 1000) # very high rates
    tau[1] <- 2e4
    w <- make_pmf_delay(rep(0:1, c(1, 10)))
    
    res <- simulate_outbreak_step(
      t = 5, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    
    expect_identical(res$S, !res$I)
    expect_true(all(res$I))
    expect_equal(res$date_infection, rep(c(1,6), c(2, 998)))
    expect_equal(nrow(res$tree), 998)
    expect_equal(ncol(res$tree), 3L)
    expect_identical(names(res$tree), c("from", "to", "date"))
    expect_equal(res$tree$date, rep(6, 998))
    freq_inf_1 <- sum(res$tree$from == 1)
    freq_inf_2 <- sum(res$tree$from == 2)
    expect_true(freq_inf_1 / freq_inf_2 > 1.5)
    expect_true(freq_inf_1 / freq_inf_2 < 2.5)
    
    
    ## Test that spread occurs next day for w = c(0, 1)
    ## There is one newly infected individual at t = 11
    ## There should be:
    ## - no further spread at t=11
    ## - all others should get infected at t=12
    
    labels <- letters[1:13]
    S <- c(FALSE, rep(TRUE, 12))
    I <- !S
    date_infection <- c(11, rep(-1L, 12))
    C <- matrix(1, 13, 13)
    diag(C) <- 0
    tau <- 1e5 # very high rates
    w <- make_pmf_delay(0:1)
    
    res <- simulate_outbreak_step(
      t = 11, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    expect_equal(nrow(res$tree), 0L)
    
    res <- simulate_outbreak_step(
      t = 12, 
      labels = labels, 
      S = S, 
      I = I, 
      date_infection = date_infection, 
      C = C, 
      tau = tau, 
      w = w
    )
    expect_equal(nrow(res$tree), 12L)
    expect_equal(res$date_infection, c(11, rep(12, 12)))
  }
)
