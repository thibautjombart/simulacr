test_that(
  "subsetting simulacr objects works as expected", {
    set.seed(123)
    x <- simulate_outbreak(60, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))
    plot(x)
    
    expect_identical(x, subset(x))
  })