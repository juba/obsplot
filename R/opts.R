#' Define an obsplot options
#'
#' @param g an obsplot object
#' @param ... named options
#' @export

opts <- function(g, ...) {
    new_opts <- list(...)

    if (!is.null(new_opts$width) || !is.null(new_opts$height)) {
        warning("width and height must only be defined in obsplot(). Values set in opts() have been ignored.")
        new_opts$width <- NULL
        new_opts$height <- NULL
    }

    if (is.null(g$x$opts)) {
        updated_opts <- new_opts
    } else {
        updated_opts <- utils::modifyList(g$x$opts, new_opts, keep.null = TRUE)
    }

    g$x$opts <- updated_opts
    g
}

#' Define an obsplot style options
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
