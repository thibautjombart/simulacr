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
    
  }
)
