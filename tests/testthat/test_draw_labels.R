test_that(
  "draw_labels() gives expect errors", {
    
    msg <- "n must be >= 1"
    expect_error(draw_labels(0), msg)
  
    msg <- "size must be >= 1"
    expect_error(draw_labels(1, 0), msg)
    
  }
)




test_that(
  "draw_labels() gives expected results", {
    
    res <- draw_labels()
    expect_true(is.character(res))
    expect_identical(length(res), 1L)
    expect_identical(nchar(res), 6L)
    
    res <- draw_labels(3, 10)
    expect_true(is.character(res))
    expect_identical(length(res), 3L)
    expect_identical(nchar(res), rep(10L, 3))
    
  }
)