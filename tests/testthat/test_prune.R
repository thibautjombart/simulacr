set.seed(123)
x <- simulate_outbreak(50, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))

test_that(
  "prune() issues the expected errors", {
    
    msg <- "x should be a simulacr object"
    expect_error(prune("abcd"), msg)
   
  }
)


test_that(
  "prune() outputs the correct results", {
    
    ## pruning with NULL returns input
    expect_identical(x, prune(x))
    
    ## test that results for the first case -> no tree, no case
    res <- prune(x, get_id(x)[1])
    expect_equal(nrow(get_tree(res)), 0L)
    
    ## test that removing non-cases does not change the tree and is equivalent
    ## to retaining only cases
    res <- prune(x, get_id(subset(x, casedef = "non_case")))
    expect_identical(get_tree(x), get_tree(res))
    expect_identical(res, subset(x, casedef = "case"))
    
    ## test results on determined tree structure
    x <-  structure(
      list(
        linelist = data.frame(
          id = as.character(1:7),
          casedef = rep("case", 7),
          date_infection = 1:7,
          stringsAsFactors = FALSE
        ),
        tree = data.frame(
          from = c(NA_character_, as.character(c(1,1,1,2,3,3))),
          to = as.character(1:7),
          date = 1:7,
          stringsAsFactors = FALSE
        )
      ),
      class = c("simulacr", "list")
    )
  
    res <- prune(x, c("2", "3"))
    exp_res <- list(
      `1` = c("2", "3", "4", "5", "6", "7"), 
      `2` = "5", 
      `3` = c("6", "7")
    )
    expect_equal(
      unname(unlist(get_tree(res))), 
      c(NA_character_, "1", "1", "4")
    )
    
  }
)
    