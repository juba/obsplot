#' Add a facet to an obsplot
#'
#' @param g an obsplot object
#' @param data optional data
#' @param ... options passed to define the facet
#' @export

facet <- function(g, data = NULL, ...) {
  opts <- rlang::enquos(...)
  check_data <- data %||% g$x$data$data
  opts <- quosures2opts_data(check_data, opts)
  data <- add_metadata(data)
  g$x$facet <- list(data = data, opts = opts)
  g
}
