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
