test_that(
  "make_random_contacts() issues expected errors", {
    
    msg <- "'rate' has length 0"
    expect_error(make_random_contacts(10, NULL), msg)
    
    msg <- "'rate' should be numeric"
    expect_error(make_random_contacts(10, letters), msg)
    
    msg <- "'rate' should be finite"
    expect_error(make_random_contacts(10, NA_real_), msg)
    
    msg <- "'rate' should be >= 0"
    expect_error(make_random_contacts(11, -1:9), msg)
   
    msg <- "'rate' should have length 'n'"
    expect_error(make_random_contacts(11, 1:15), msg)
    
  }
)



test_that(
  "make_random_contacts() returns expected outputs", {
    
    ## rate 0 -> no contact
    res <- make_random_contacts(3)
    expect_identical(res, matrix(0, 3, 3))
    
    
    ## check that average nb of contacts is as expected according to rates 
    ## (very high rates)
    res <- make_random_contacts(55, 1e4)
    expect_equal(dim(res), c(55, 55))
    expect_equal(sum(diag(res)), 0)
    n_contacts <- rowSums(res)
    expect_true(mean(n_contacts) > 9900)
    expect_true(mean(n_contacts) < 10100)
    
    
    ## check that individual contact rates variation have expected impact
    ## using very high rates to avoid stochastic issues when comparing outputs
    res <- make_random_contacts(4, c(190, 0, 5500, 0))
    n_contacts <- rowSums(res)
    expect_equal(n_contacts[2], 0)
    expect_equal(n_contacts[4], 0)
    expect_true(n_contacts[1] > 0)
    expect_true(n_contacts[3] > 0)
    expect_true(n_contacts[3] > n_contacts[1])
    
    
    ## check that binary output matches positive nb of contacts for a given 
    ## random seed
    set.seed(123)
    res_1 <- make_random_contacts(5, 2)
   
    set.seed(123)
    res_2 <- make_random_contacts(5, 2, TRUE)
    
    expect_equal(1* (res_1 > 0), res_2)
    
    }
)