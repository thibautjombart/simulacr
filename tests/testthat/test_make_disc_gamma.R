test_that(
  "make_disc_gamma() issues correct errors",
  {
    msg <- "'mean' must be a finite number"
    expect_error(make_disc_gamma(Inf, 1), msg)
    
    msg <- "'sd' must be a finite number"
    expect_error(make_disc_gamma(1, Inf), msg)
    
  }
)



test_that(
  "make_disc_gamma() returns correct outputs", 
  {
    res <- make_disc_gamma(12, 8.5)
    expect_true(inherits(res, "distcrete"))
    
    samp <- res$r(1e4)
    expect_true(mean(samp) > 10)
    expect_true(mean(samp) < 13)
    expect_true(sd(samp) > 7)
    expect_true(sd(samp) < 10)
    
  }
)