#' Plotting method for simulacr objects
#'
#'The plot method for simulacr objects can be used to produce different types of 
#' graphs, either interactive (by default) or static.
#'
#' @export
#'
#' @author Thibaut Jombart, Cyril Geismar
#'
#' @importFrom graphics plot
#'
#' @param x A `simulacr` object returned by [simulate_outbreak()].
#'
#' @param method A character string indicating the plotting method:
#'   `"visNetwork"` (default) for an interactive plot, `"igraph"` for a static 
#'   graph, or `"tree"` for a static tree with a time axis (also uses igraph).
#' @param ... For `plot`, further arguments passed to
#'   [epicontacts::plot.epicontacts()] or [igraph::plot.igraph()].
#'   For "tree", `rescale = FALSE` and `asp = 0` are fixed.
#' 
#' @param cases_only A `logical` indicating if cases only should be included in
#'   the converted object; defaults to `FALSE`. Fixed to `TRUE` if `method` is 
#'   "tree"
#'   
#' @examples
#' 
#' ## simulate an outbreak
#' set.seed(2)
#' x <- simulate_outbreak(
#'   n = 100, duration = 50, tau = 0.3, 
#'   contacts = make_random_contacts(100, 5)
#' )
#' 
#' ## plot the outbreak using the default interactive method
#' plot(x)
#' 
#' ## plot using igraph, with some examples of customization
#' plot(x, method = "igraph")
#' plot(x, method = "igraph", vertex.color = "pink", 
#'   vertex.size = 10, edge.arrow.size = 0.5
#' )
#' 
#' ## plot using a tree layout with time axis
#' plot(x, method = "tree")
#' plot(
#'   x, "tree", edge.color= "red", edge.arrow.size = 2,
#'   vertex.shape = "circle", vertex.size = 20,  vertex.label.cex = 1.5   
#' )

plot.simulacr <- function(x, method = c("visNetwork", "igraph", "tree"), 
                          cases_only = FALSE, ...) {
  method <- match.arg(method)

  ## method for interactive plot using visNetwork
  if (method == "visNetwork") {
    type_pal <- grDevices::colorRampPalette(c("#ff8080", "#c2d6d6"))
    args <- list(
      x = as_epicontacts(x, cases_only = cases_only),
      method = "visNetwork",
      node_color = "casedef",
      col_pal = type_pal,
      thin = FALSE
    )
    args <- modify_defaults(args, list(...), strict = FALSE)
    out <- do.call(plot, args)
    return(out)
  }

  ## method for a static graph using igraph
  if (method == "igraph") {
    out <- as_igraph(x, cases_only = cases_only)
    casedef_color <- c("case" = "#ff8080", "non_case" = "#c2d6d6")
    colors <- casedef_color[igraph::V(out)$casedef]
    args <- list(
      x = out,
      vertex.color = colors,
      vertex.label.cex = 0.75,
      vertex.label.color = "black",
      vertex.size = 15,
      vertex.frame.color = "grey",
      edge.arrow.size = 0.3
    )
    args <- modify_defaults(args, list(...), strict = FALSE)
    do.call(plot, args)
    invisible(out)
  }

  if(method == "tree") {
    out <- as_igraph(x, cases_only = TRUE)
    casedef_color <- c("case" = "#ff8080", "non_case" = "#c2d6d6")
    colors <- casedef_color[igraph::V(out)$casedef]
  
    ## Keep horizontal tree positions; use infection dates vertically
    dates <- igraph::V(out)$date_infection
    coords <- igraph::layout_as_tree(out)
    coords[, 2] <- -dates
    out <- igraph::set_graph_attr(out, "layout", coords)
    out <- igraph::set_graph_attr(out, "ylab", "Date of Infection")
    
    ## Show black labels and arrows without node shapes
    args <- list(
      x = out,
      vertex.color = colors,
      vertex.shape = "none",
      vertex.label.color = "black",
      vertex.label.cex = 0.8,
      edge.color = "grey",
      edge.arrow.size = 0.3
    )
    args <- modify_defaults(args, list(...), strict = FALSE)
    args$rescale <- FALSE
    args$asp <- 0
    do.call(plot, args)
    
    ## Label the vertical axis with positive times
    ticks <- pretty(range(dates))
    graphics::axis(2, at = -ticks, labels = ticks, las = 1)
    invisible(out)
  }
 
}
