#' Split a string into a list of substrings
#'
#' @param x A character vector with one element
#' @param sep A character vector indicating what to split on
#'
#' @return A character vector
#' @export
#'
#' @examples
#' x <- c("alpha,bravo,charlie,delta,echo,foxtrot")
#' strsplit1(x, ",")
strsplit1 <- function(x, sep) {
  strsplit(x, sep)[[1]]
}
