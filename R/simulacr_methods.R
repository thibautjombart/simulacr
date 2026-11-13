#' Basic methods for simulacr objects
#'
#' These functions implement basic methods for simulacr objects as returned by 
#' [simulate_outbreak()]. They include:
#' * `as_epicontacts`: conversion to `epicontacts` object
#' * `as.epicontacts`: alias for `as_epicontacts`
#'
#' @rdname simulacr_methods
#'
#' @aliases as_epicontacts.simulacr as.epicontacts.simulacr
#'
#' @export
#'
#' @param x an object to be converted to `epicontacts`
#'

as_epicontacts <- function(...) {
  UseMethod("as_epicontacts")
}

#' @rdname outbreak_methods
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
#' @param ... for `plot`, arguments passed to `plot.epicontacts` in the
#'   `epicontacts` package.

plot.simulacr <- function(x, ...) {
  type_pal <- grDevices::colorRampPalette(c("#ff8080", "#c2d6d6"))
  out <- plot(as.epicontacts(x), node_color = "casedef", col_pal = type_pal)
  out
}
