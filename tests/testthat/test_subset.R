test_that(
  "subsetting simulacr objects works as expected", {
    set.seed(123)
    x <- simulate_outbreak(60, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))

    expect_identical(x, subset(x))
    
    ## we subset the same set of individuals but with different approaches and 
    ## check that the results are identical
    sub_id <- c(1:4, 7)
    res_1 <- subset(x, id = sub_id)
    expect_identical(res_1$linelist$id, x$linelist$id[sub_id])
    
    sub_logical <- rep(FALSE, nrow(x$linelist))
    sub_logical[sub_id] <- TRUE
    res_2 <- subset(x, id = sub_logical)
    expect_identical(res_1, res_2)
    
    sub_neg_id <- setdiff(1:nrow(x$linelist), sub_id)
    res_3 <- subset(x, id = -sub_neg_id)
    expect_identical(res_1, res_3)
    
    sub_labels <- x$linelist$id[sub_id]
    res_4 <- subset(x, id = sub_labels)
    expect_identical(res_1, res_4)
    
    
    ## check time windows
    expect_identical(
      subset(x, start_date = 4), 
      subset(x, x$linelist$date_infection >=4)
    )
    expect_identical(
      subset(x, end_date = 5), 
      subset(x, x$linelist$date_infection <=5)
    )
    expect_identical(
      subset(x, start_date = 4, end_date = 5), 
      subset(x, x$linelist$date_infection >=4 & x$linelist$date_infection <=5)
    )
    
  }
)