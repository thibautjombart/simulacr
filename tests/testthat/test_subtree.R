set.seed(123)
x <- simulate_outbreak(50, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))

test_that(
  "subtree() issues the expected errors", {
    
    msg <- "x should be a simulacr object"
    expect_error(subtree("lkm"), msg)
    
    msg <- "ids should be a logical, integer, or character vector"
    expect_error(subtree(x, NULL), msg)
    
  }
)


test_that(
  "subtree() outputs the correct results", {
    
  }
)