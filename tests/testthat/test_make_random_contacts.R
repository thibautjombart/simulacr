test_that(
  "make_random_contacts() issues expected errors", {
    
    msg <- "'rate' has length 0"
    expect_error(make_random_contacts(10, NULL), msg)
    
    msg <- "'rate' should be numeric"
    expect_error(make_random_contacts(10, letters), msg)
    
    msg <- "'rate' should be finite"
    expect_error(make_random_contacts(10, NA_real_), msg)
    
    msg <- "'rate' should be >= 0"
    expect_error(make_random_contacts(11, -1:10), msg)
    
  }
)



test_that(
  "make_random_contacts() returns expected outputs", {
    
    
    
  }
)