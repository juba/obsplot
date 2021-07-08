#' Add a mark to an obsplot
#'
#' @param g an obsplot object
#' @param data optional data
#' @param ... named options passed to define the mark
#' @export
mark_area <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2",  "z"),
        status  = c("req", "req", "opt", "opt", "opt"),
        type    = c("num", "num", "num", "num", "cat")
    )
    mark_("area", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_areaX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",  "y",    "z"),
        status  = c("opt", "req", "opt"),
        type    = c("num", "num", "cat")
    )
    mark_("areaX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_areaY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",  "y",    "z"),
        status  = c("req", "opt", "opt"),
        type    = c("num", "num", "cat")
    )
    mark_("areaY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_barX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x1",  "x2",  "x",   "y"),
        status  = c("opt", "opt", "opt", "opt"),
        type    = c("", "", "")
    )
    mark_("barX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_barY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("y1",  "y2",  "x",   "y"),
        status  = c("opt", "opt", "opt", "opt"),
        type    = c("", "", "")
    )
    mark_("barY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_cell <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt"),
        type    = c("", "")
    )
    mark_("cell", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_cellX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt"),
        type    = c("", "")
    )
    mark_("cellX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_cellY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt"),
        type    = c("", "")
    )
    mark_("cellY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_dot <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "r"),
        status  = c("req", "req", "opt"),
        type    = c("num", "num", "radius")
    )
    mark_("dot", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_dotX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt"),
        type    = c("",    "")
    )
    mark_("dotX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_dotY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt"),
        type    = c("",    "")
    )
    mark_("dotY", g, data, channels, ...)
}


#' @rdname mark_area
#' @export
mark_line <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "z"),
        status  = c("req", "req", "opt"),
        type    = c("num", "num", "cat")
    )
    mark_("line", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_lineX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "z"),
        status  = c("opt", "opt", "opt"),
        type    = c("",    "",    "cat")
    )
    mark_("lineX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_lineY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "z"),
        status  = c("opt", "opt", "opt"),
        type    = c("",    "",    "cat")
    )
    mark_("lineY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_link <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x1",   "y1", "x2",  "y2"),
        status  = c("req", "req", "req", "req"),
        type    = c("num", "num", "num", "num")
    )
    mark_("link", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_rect <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2"),
        status  = c("req", "req", "req", "req"),
        type    = c("num", "num", "num", "num")
    )
    mark_("rect", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_rectX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2",  "x"),
        status  = c("opt", "req", "opt", "req", "opt"),
        type    = c("num", "num", "num", "num", "num")
    )
    mark_("rectX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_rectY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2",  "y"),
        status  = c("req", "opt", "req", "opt", "opt"),
        type    = c("num", "num", "num", "num", "num")
    )
    mark_("rectY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_ruleX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y1",  "y2",  "y"),
        status  = c("opt", "opt", "opt", "opt"),
        type    = c("num", "num", "num", "num")
    )
    mark_("ruleX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_ruleY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("y",   "x1",  "x2",  "x"),
        status  = c("opt", "opt", "opt", "opt"),
        type    = c("num", "num", "num", "num")
    )
    mark_("ruleY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_text <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",  "text", "fontSize", "rotate"),
        status  = c("opt", "opt", "req", "opt",      "opt"),
        type    = c("num", "num", "cat", "num",      "num")
    )
    mark_("text", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_textX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",  "text", "fontSize", "rotate"),
        status  = c("opt", "opt", "req", "opt",      "opt"),
        type    = c("num", "num", "cat", "num",      "num")
    )
    mark_("textX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_textY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y",  "text", "fontSize", "rotate"),
        status  = c("opt", "opt", "req", "opt",      "opt"),
        type    = c("num", "num", "cat", "num",      "num")
    )
    mark_("textY", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_tickX <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("req", "opt"),
        type    = c("num", "num")
    )
    mark_("textX", g, data, channels, ...)
}

#' @rdname mark_area
#' @export
mark_tickY <- function(g, data = NULL, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "req"),
        type    = c("num", "num")
    )
    mark_("textY", g, data, channels, ...)
}


#' Add a decoration mark to an obsplot
#'
#' @param g an obsplot object
#' @param ... options passed to define the mark
#' @export
mark_frame <- function(g, ...) {
    mark_("frame", g, data = NULL, mark_channels = NULL, ...)
}


mark_ <- function(mark_type, g, data = NULL, mark_channels, ...) {

    opts <- list(...)
    check_data(data)

    data_check <- data 
    if (is.null(data_check)) data_check <- g$x$data

    check_channels(
        data = data_check,
        mark_channels = mark_channels,
        mark_args = list(...)
    )

  mark <- list(type = mark_type, data = data, opts = opts)
  g$x$marks <- append(g$x$marks, list(mark))
  g
}
