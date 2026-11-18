x <- structure(
  list(
    linelist = data.frame(
      id = c("a", "b", "c", "d"),
      casedef = c("case", "case", "case", "non_case"),
      date_infection = c(1, 4, 1, -1),
      stringsAsFactors = FALSE
    ),
    tree = data.frame(
      from = c(NA_character_, "a", "b"),
      to = c("a", "b", "c"),
      date = c(1, 4, 10),
      stringsAsFactors = FALSE
    )
  ),
  class = c("simulacr", "list")
)



test_that(
  "Conversion to epicontacts works as expected", 
  {
    ## basic conversion with all individuals
    out <- as_epicontacts(x)
    expect_s3_class(out, "epicontacts")
    expect_identical(x$linelist, out$linelist)
    expect_identical(x$tree, out$contacts)
    expect_true(out$directed)
    
    ## keeping only cases
    out <- as_epicontacts(x, cases_only = TRUE)
    expect_s3_class(out, "epicontacts")
    expect_identical(x$linelist[x$linelist$casedef == "case", ], out$linelist)
    expect_identical(x$tree, out$contacts)
    expect_true(out$directed)
    
  }
)



test_that(
  "Conversion to igraph works as expected", 
  {
    ## basic conversion with all individuals
    out <- as_igraph(x)
    expect_s3_class(out, "igraph")
    expect_identical(labels(igraph::V(out)), x$linelist$id)
    
    ## keeping only cases
    out <- as_igraph(x, cases_only = TRUE)
    expect_s3_class(out, "igraph")
    expect_identical(labels(igraph::V(out)), x$linelist$id[x$linelist$casedef == "case"])
    E <- igraph::as_edgelist(out)
    expect_equal(as.vector(E), as.vector(as.matrix(x$tree[2:3, 1:2])))
  }
)



test_that("tree plots preserve edges and infection times", {
  x <- structure(
    list(
      linelist = data.frame(
        id = c("a", "b", "c"),
        casedef = "case",
        date_infection = c(1, 4, 10),
        stringsAsFactors = FALSE
      ),
      tree = data.frame(
        from = c(NA_character_, "a", "b"),
        to = c("a", "b", "c"),
        date = c(1, 4, 10),
        stringsAsFactors = FALSE
      )
    ),
    class = c("simulacr", "list")
  )

  ## Plot without opening a window or writing a file
  draw <- function() {
    grDevices::pdf(NULL)
    on.exit(grDevices::dev.off())
    plot(x, method = "tree")
  }
  out <- draw()

  ## Keep the three cases and the two transmission links
  expect_equal(igraph::vcount(out), 3)
  expect_true(igraph::is_directed(out))
  expect_equal(
    igraph::as_edgelist(out),
    matrix(c("a", "b", "b", "c"), ncol = 2, byrow = TRUE)
  )

  ## Match each individual's vertical position to its infection time
  coords <- igraph::graph_attr(out, "layout")
  expected_y <- c(a = -1, b = -4, c = -10)
  expect_equal(
    coords[, 2],
    unname(expected_y[igraph::V(out)$name])
  )
})
