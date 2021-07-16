#' Add or modify options to an obsplot
#'
#' @param g an obsplot object
#' @param ... named options
#' @export

opts <- function(g, ...) {
    new_opts <- list(...)
    if (is.null(g$x$opts)) {
        updated_opts <- new_opts
    } else {
        updated_opts <- utils::modifyList(g$x$opts, new_opts)
    }
    g$x$opts <- updated_opts
    g
}

#' Add or modify style options to an obsplot
#'
#' @param g an obsplot object
#' @param ... named style options
#' @export

style <- function(g, ...) {
    new_opts <- list(...)
    if (is.null(g$x$opts$style)) {
        updated_opts <- new_opts
    } else {
        updated_opts <- utils::modifyList(g$x$opts$style, new_opts)
    }
    g$x$opts$style <- updated_opts
    g
}
