#' Add a facet to an obsplot
#'
#' @param g an obsplot object
#' @param data optional data
#' @param ... options passed to define the facet
#' @export

facet <- function(g, data = NULL, ...) {
  data <- add_metadata(data)
  g$x$facet <- list(data = data, opts = list(...))
  g
}
