test_that(
  "make_panmictic_contacts() works as expected",
  {
    exp_out <- matrix(1, nrow = 3, ncol = 3)
    diag(exp_out) <- 0
    expect_equal(make_panmictic_contacts(3), exp_out)
    
    expect_equal(make_panmictic_contacts(1), matrix(0, 1, 1))
    
    expect_equal(nrow(make_panmictic_contacts(5)), 5)
    expect_equal(ncol(make_panmictic_contacts(5)), 5)
  }
)
    