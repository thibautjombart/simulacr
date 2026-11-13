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
    
  }
)
