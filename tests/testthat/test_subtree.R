set.seed(123)
x <- simulate_outbreak(50, 10, tau = 0.05, w = c(0, 1, 1, 1, 1, 1))

test_that(
  "subtree() issues the expected errors", {
    
    msg <- "x should be a simulacr object"
    expect_error(subtree("lkm"), msg)
    
    msg <- "ids should be a logical, integer, or character vector"
    expect_error(subtree(x, NULL), msg)
   
    msg <- "some ids are not listed cases in x"
    expect_error(subtree(x, "toto"), msg)
  
    msg <- "some ids are not listed cases in x"
    not_a_case <- get_id(subset(x, casedef = "non_case"))[1]
    expect_error(subtree(x, not_a_case), msg)
    
  }
)


test_that(
  "subtree() outputs the correct results", {
    
    ## test that results for the first case = all cases
    res <- sort(unname(unlist(subtree(x, get_id(x)[1]))))
    exp_res <- sort(get_id(subset(x, casedef = "case"))[-1])
    exp_res <- setdiff(exp_res, get_id(subset(x, casedef = "case"))[1])
    expect_identical(res, exp_res)
    
    ## test that cases with R = 0 have empty subtrees
    Ri <- get_R(x)
    ids_0 <- names(Ri)[Ri == 0]
    res <- subtree(x, ids_0, include_empty = TRUE)
    expect_identical(unlist(res), character(0))
    
    ## test that include_empty does what it should
    res_1 <- subtree(x, include_empty = TRUE)
    res_2 <- subtree(x, include_empty = FALSE)
    expect_identical(
      sort(names(res_1)),
      sort(c(names(res_2), ids_0))
    )
    
    
    ## test results on determined subtree
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
  
    res <- subtree(x)
    exp_res <- list(
      `1` = c("2", "3", "4", "5", "6", "7"), 
      `2` = "5", 
      `3` = c("6", "7")
    )
    expect_identical(res, exp_res)
}
)
    