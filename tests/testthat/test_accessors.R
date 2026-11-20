set.seed(111)
x <- simulate_outbreak(30, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))


test_that(
  "accessors issue the correct errors",
  {
    
    msg <- "No method for object of class character"
    expect_error(get_n("lkdsf"), msg)
    
    msg <- "No method for object of class NULL"
    expect_error(get_n_cases(NULL), msg)
 
    msg <- "No method for object of class integer"
    expect_error(get_n_non_cases(1L), msg)
    
    msg <- "No method for object of class character"
    expect_error(get_date_infection("lkdsf"), msg)
    
    
  }
)



test_that(
  "accessors work as expected",
  {
    expect_equal(get_n(x), 30)
    expect_equal(get_n_cases(x), sum(x$linelist$casedef == "case"))
    expect_equal(get_n_non_cases(x), sum(x$linelist$casedef == "non_case"))
    expect_equal(get_date_infection(x), x$linelist$date_infection)
    
  }
)