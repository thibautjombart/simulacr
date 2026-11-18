animation_example <- structure(
  list(
    linelist = data.frame(
      id = c("a", "b", "c", "d"),
      casedef = c("case", "case", "case", "non_case"),
      date_infection = c(1, 4, 10, -1),
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


test_that("animate_outbreak() updates cases and edges using one fixed layout", {
  x <- animation_example
  frames <- list()
  coords <- matrix(seq_len(8), ncol = 2)

  ## temporarily replace plot.simulacr()
  ## with a function that records what it receives.
  local_mocked_bindings(
    plot.simulacr = function(x, layout, ...) {
      frames[[length(frames) + 1L]] <<- list(
        cases = x$linelist$id[x$linelist$casedef == "case"],
        edges = x$tree,
        layout = layout
      )
    },
    .package = "simulacr"
  )

  animate_outbreak(x, t = c(1, 4, 10), layout = coords)
  expect_length(frames, 3)

  ## Cases appear at their infection times
  expect_identical(frames[[1]]$cases, "a")
  expect_identical(frames[[2]]$cases, c("a", "b"))
  expect_identical(frames[[3]]$cases, c("a", "b", "c"))

  ## Transmission rows appear at the same times
  expect_equal(frames[[1]]$edges, x$tree[1, , drop = FALSE])
  expect_equal(frames[[2]]$edges, x$tree[1:2, ])
  expect_equal(frames[[3]]$edges, x$tree)

  ## Every frame uses the same coordinates
  for (frame in frames) {
    expect_equal(frame$layout, coords)
  }
})
