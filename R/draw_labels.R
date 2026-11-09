#' Genrate random labels
#'
#' This function is a simple wrapper for `stri_rand_strings` from the `stringi`
#' package to generate random alphanumeric labels.
#'
#' @export
#' 
#' @author Thibaut Jombart
#'
#' @param n the number of labels to generate; defaults to 1
#'
#' @param size the number of characters of the labels; defaults to 6
#'
#' @examples
#'
#' draw_labels()
#' draw_labels(10, 3)

draw_labels <- function(n = 1, size = 6) {
  if(n < 1) stop("n must be >= 1")
  if(size < 1) stop("size must be >= 1")
  stringi::stri_rand_strings(n = n, length = size, pattern = "[A-Za-z0-9]")
}
