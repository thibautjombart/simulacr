test_that(
  "simulate_outbreak() issues the expected errors", {
    ## test n
    msg <- "n must be finite"
    expect_error(simulate_outbreak(n = Inf), msg)
    
    msg <- "n must be finite"
    expect_error(simulate_outbreak(n = NA_real_), msg)
    
    msg <- "n must be numeric"
    expect_error(simulate_outbreak(n = NULL), msg)
    
    msg <- "n must be >= 1"
    expect_error(simulate_outbreak(n = 0), msg)
    
    
    ## test duration
    msg <- "duration must be finite"
    expect_error(simulate_outbreak(n = 1, duration = Inf), msg)
    
    msg <- "duration must be finite"
    expect_error(simulate_outbreak(n = 1, duration = NA_real_), msg)
    
    msg <- "duration must be numeric"
    expect_error(simulate_outbreak(n = 1, duration = NULL), msg)
    
    msg <- "duration must be >= 1"
    expect_error(simulate_outbreak(n = 1, duration = 0), msg)
   
    
    ## test tau (vector of rates)
    msg <- "tau has length 0"
    expect_error(simulate_outbreak(n = 1, tau = NULL), msg)
    
    msg <- "tau must be finite"
    expect_error(simulate_outbreak(n = 1, tau = Inf), msg)
    
    msg <- "tau must be finite"
    expect_error(simulate_outbreak(n = 1, tau = NA_real_), msg)
    
    msg <- "tau must be numeric"
    expect_error(simulate_outbreak(n = 1, tau = "opkk"), msg)
    
    msg <- "tau must be >= 0"
    expect_error(simulate_outbreak(n = 2, tau = c(0, -1.123)), msg)
    
    
    ## test contacts provided as matrix
    C <- matrix(1, ncol = 3, nrow = 3)
    msg <- "contacts dimension must be n x n"
    expect_error(simulate_outbreak(n = 2, contacts = C), msg)  
    
    C <- matrix(1, ncol = 3, nrow = 3)
    C[2, 3] <- NA_real_
    msg <- "contacts has non-finite entries"
    expect_error(simulate_outbreak(n = 3, contacts = C), msg)
    
    C <- matrix(1, ncol = 3, nrow = 3)
    C[2, 3] <- -1.153
    msg <- "contacts has entries < 0"
    expect_error(simulate_outbreak(n = 3, contacts = C), msg)
    
    C <- matrix("kldsa", ncol = 3, nrow = 3)
    msg <- "contacts must be numeric"
    expect_error(simulate_outbreak(n = 3, contacts = C), msg)
    
    
    ## test contacts provided as function
    C <- function(a, b) NULL
    msg <- "if `contacts` is a function, it should accept a single argument \\(t\\)"
    expect_error(simulate_outbreak(n = 4, contacts = C), msg)
    
    C <- function(t) NULL
    msg <- "contacts\\(1\\) is NULL"
    expect_error(simulate_outbreak(n = 4, contacts = C), msg)
  
    C <- function(t) matrix(1, ncol = 2, nrow = 2)
    msg <- "contacts\\(1\\) dimension must be n x n"
    expect_error(simulate_outbreak(n = 3, contacts = C), msg)
    
    C <- function(t) matrix(Inf, ncol = 2, nrow = 2)
    msg <- "contacts\\(1\\) has non-finite entries"
    expect_error(simulate_outbreak(n = 2, contacts = C), msg)
    
    C <- function(t) {
      if (t < 10) matrix(1, ncol = 4, nrow = 4) else NULL
    }
    msg <- "contacts\\(duration\\) is NULL"
    expect_error(simulate_outbreak(n = 4, duration = 10, contacts = C), msg)

    C <- function(t) {
      if (t < 10) matrix(1, ncol = 4, nrow = 4) else matrix(-1, ncol = 4, nrow = 4)
    }
    msg <- "contacts\\(duration\\) has entries < 0"
    expect_error(simulate_outbreak(n = 4, duration = 10, contacts = C), msg)
    
    C <- function(t) {
      if (t < 5) matrix(1, ncol = 4, nrow = 4) else matrix("lkm", ncol = 4, nrow = 4)
    }
    msg <- "contacts\\(duration\\) must be numeric"
    expect_error(simulate_outbreak(n = 4, duration = 5, contacts = C), msg)
    
    C <- function(t) {
      if (t < 5) matrix(1, ncol = 4, nrow = 4) else matrix(NA_real_, ncol = 4, nrow = 4)
    }
    msg <- "contacts\\(duration\\) has non-finite entries"
    expect_error(simulate_outbreak(n = 4, duration = 5, contacts = C), msg)
    
  }
)




test_that(
  "simulate_outbreak() returns correct results",
  {
    ## basic test with a single individual
    res <- simulate_outbreak(1)
    expect_true(inherits(res, "simulacr"))
    expect_true(is.list(res))
    expect_identical(names(res), c("linelist", "tree"))
    expect_identical(names(res$linelist), c("id", "casedef", "date_infection"))
    expect_identical(names(res$tree), c("from", "to", "date"))
    expect_equal(res$linelist$casedef, "case")
    expect_equal(res$linelist$date_infection, 1)
    expect_true(is.na(res$tree$from[1]))
    expect_equal(nrow(res$tree), 1)
    
    
    ## no spread in the absence of contacts   
    res <- simulate_outbreak(10, 100, contacts = matrix(0, ncol = 10, nrow = 10), tau = 1000)
    expect_equal(nrow(res$tree), 1)
    expect_equal(res$linelist$casedef[1], "case")
    expect_true(all(res$linelist$casedef[-1] == "non_case"))
    
    
    ## no spread with tau = 0
    res <- simulate_outbreak(23, 100, tau = 0)
    expect_equal(nrow(res$tree), 1)
    expect_equal(res$linelist$casedef[1], "case")
    expect_true(all(res$linelist$casedef[-1] == "non_case"))
    
    
    ## total spread with high tau
    res <- simulate_outbreak(69, 70, tau = 1e4)
    expect_equal(nrow(res$tree), 69)
    expect_true(all(res$linelist$casedef == "case"))
    
    
    ## spread one individual at a time with an off diagonal 1 contact matrix
    C <- matrix(0, ncol = 10, nrow = 10)
    for (i in 1:9) {
      C[i, i + 1] <- 1
    }
    res <- simulate_outbreak(10, 12, contacts = C, tau = 1e4, w = c(0, 1))
    expect_equal(res$linelist$date_infection, 1:10)
    expect_equal(res$tree$date, 1:10)
    expect_true(all(res$linelist$casedef == "case"))
    expect_identical(res$tree$from[-1], res$linelist$id[1:9])
    expect_identical(res$tree$to, res$linelist$id)
    
  }
)
