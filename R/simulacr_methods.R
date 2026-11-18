#' Basic methods for simulacr objects
#'
#' These functions implement basic methods for simulacr objects as returned by
#' [simulate_outbreak()]. They include:
#' * `as_epicontacts`: conversion to `epicontacts` object
#' * `as.epicontacts`: alias for `as_epicontacts`
#' * `plot`: interactive or static transmission tree plots
#'
#' @rdname simulacr_methods
#'
#' @aliases as_epicontacts.simulacr as.epicontacts.simulacr
#'
#' @export
#'
#' @param x A `simulacr` object returned by [simulate_outbreak()].
#'

as_epicontacts <- function(...) {
  UseMethod("as_epicontacts")
}

#' @rdname simulacr_methods
#' @export

as.epicontacts <- as_epicontacts


#' @rdname simulacr_methods
#' @export

as_epicontacts.simulacr <- function(x, ...) {
  epicontacts::make_epicontacts(
    linelist = x$linelist,
    contacts = x$tree,
    directed = TRUE
  )
}


#' @rdname simulacr_methods
#' @export
#' @importFrom graphics plot
#' @param method A character string indicating the plotting method:
#'   `"visNetwork"` (default) for an interactive plot, or `"igraph"` for a static
#'   tree with a time axis.
#' @param ... For `plot`, further arguments passed to
#'   [epicontacts::plot.epicontacts()] or [igraph::plot.igraph()].
#'   For igraph, `rescale = FALSE` and `asp = 0` are fixed.

plot.simulacr <- function(x, method = c("visNetwork", "igraph"), ...) {
  method <- match.arg(method)

  if (method == "visNetwork") {
    type_pal <- grDevices::colorRampPalette(c("#ff8080", "#c2d6d6"))
    args <- list(
      x = as.epicontacts(x),
      method = "visNetwork",
      node_color = "casedef",
      col_pal = type_pal,
      thin = FALSE
    )
    args <- modify_defaults(args, list(...), strict = FALSE)
    out <- do.call(plot, args)
    return(out)
  }

  out <- igraph::graph_from_data_frame(
    d = x$tree[!is.na(x$tree$from), , drop = FALSE],
    directed = TRUE,
    vertices = x$linelist[x$linelist$casedef == "case", , drop = FALSE]
  )

  ## Keep horizontal tree positions; use infection dates vertically
  dates <- igraph::V(out)$date_infection
  coords <- igraph::layout_as_tree(out)
  coords[, 2] <- -dates
  out <- igraph::set_graph_attr(out, "layout", coords)
  out <- igraph::set_graph_attr(out, "ylab", "Date of Infection")

  ## Show black labels and arrows without node shapes
  igraph::V(out)$shape <- "none"
  igraph::V(out)$label.color <- "black"
  igraph::V(out)$label.cex <- 0.65
  igraph::E(out)$color <- "grey"
  igraph::E(out)$arrow.size <- 0.3

  plot(
    out,
    rescale = FALSE,
    asp = 0,
    ...
  )

  ## Label the vertical axis with positive times
  ticks <- pretty(range(dates))
  graphics::axis(2, at = -ticks, labels = ticks, las = 1)

  invisible(out)
}
