test_that("igraph plots preserve edges and infection times", {
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
    plot(x, method = "igraph")
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
