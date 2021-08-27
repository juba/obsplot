#' Define an obsplot scale options
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

#' @rdname scale_color
#' @export
scale_fx <- function(g, ...) {
    scale_(g, "fx", ...)
}

#' @rdname scale_color
#' @export
scale_fy <- function(g, ...) {
    scale_(g, "fy", ...)
}

scale_ <- function(g, scale_type, ...) {
    options <- list(...)
    # Convert length 1 domain or range to a vector with the
    # value duplicated
    options$domain <- duplicate_single(options$domain)
    options$range <- duplicate_single(options$range)
    g$x$opts[scale_type] <- list(options)
    g
}

# Duplicate a single numeric value
duplicate_single <- function(value) {
    if (!is.null(value) && length(value) == 1 && is.numeric(value)) {
        return(rep(value, 2))
    }
    value
}