#' Animate epidemic spread
#'
#' Draw one igraph plot per requested time, keeping all individuals in fixed
#' positions. Case colours and edges reflect the displayed time.
#'
#' @inheritParams as_igraph x
#' @param t A non-empty vector of non-negative integer time steps.
#' @param ... Further plotting arguments. A supplied `layout` function is
#'   evaluated once. The method is fixed to "igraph" and `cases_only` to FALSE.
#'
#' @returns The complete `igraph` object with its fixed layout, invisibly.
#' @export
#'
#' @examples
#' res <- simulate_outbreak(n = 30, duration = 100, tau = 0.1)
#' animate_outbreak(res, t = c(1, 5, 10))
animate_outbreak <- function(x, t, ...) {
  if (!inherits(x, "simulacr")) {
    stop("x must be a simulacr object")
  }
  if (
    !is.numeric(t) ||
      length(t) == 0L ||
      any(!is.finite(t)) ||
      any(t < 0) ||
      any(t != floor(t))
  ) {
    stop("t must be a non-empty vector of non-negative integers")
  }

  ## Calculate positions once from the complete outbreak
  out <- as_igraph(x)
  args <- list(...)
  if (is.null(args$layout)) {
    args$layout <- igraph::layout_nicely(out)
  }
  if (is.function(args$layout)) {
    args$layout <- args$layout(out)
  }
  out <- igraph::set_graph_attr(out, "layout", args$layout)
  args$method <- "igraph"
  args$cases_only <- FALSE
  title <- args$main
  dates <- x$linelist$date_infection

  ## Update a copy at each time, retaining every individual
  for (time in t) {
    frame <- x

    is_case <- dates >= 1 & dates <= time
    frame$linelist$casedef <- ifelse(is_case, "case", "non_case")
    frame$tree <- x$tree[x$tree$date <= time, , drop = FALSE]

    ## Plot this frame
    args$x <- frame
    args$main <- if (is.null(title)) paste("date", time) else title
    do.call(plot, args)
  }

  invisible(out)
}
