#' Add or modify scale options to an obsplot
#'
#' @param g an obsplot object
#' @param ... named scale options
#' @export
scale_color <- function(g, ...) {
    scale_(g, "color", ...)
}

#' @rdname scale_color
#' @export
scale_opacity <- function(g, ...) {
    scale_(g, "opacity", ...)
}

#' @rdname scale_color
#' @export
scale_r <- function(g, ...) {
    scale_(g, "r", ...)
}

#' @rdname scale_color
#' @export
scale_x <- function(g, ...) {
    scale_(g, "x", ...)
}

#' @rdname scale_color
#' @export
scale_y <- function(g, ...) {
    scale_(g, "y", ...)
}


scale_ <- function(g, scale_type, ...) {
    g$x$opts[scale_type] <- list(list(...))
    g
}