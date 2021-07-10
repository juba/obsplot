#' Add a mark to an obsplot
#'
#' @param g an obsplot object
#' @param ... named options passed to define the mark
#'
#' ... arguments can accept at most two unnamed arguments : a data object and a call
#' to a transform function.
#' @export
mark_area <- function(g, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2",  "z"),
        status  = c("req", "req", "opt", "opt", "opt")
    )
    mark_("area", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_areaX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",  "y",    "z"),
        status  = c("opt", "opt", "opt")
    )
    mark_("areaX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_areaY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",  "y",    "z"),
        status  = c("opt", "opt", "opt")
    )
    mark_("areaY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_barX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x1",  "x2",  "x",   "y"),
        status  = c("opt", "opt", "opt", "opt")
    )
    mark_("barX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_barY <- function(g, ...) {
    channels <- data.frame(
        channel = c("y1",  "y2",  "x",   "y"),
        status  = c("opt", "opt", "opt", "opt")
    )
    mark_("barY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_cell <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt")
    )
    mark_("cell", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_cellX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt")
    )
    mark_("cellX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_cellY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "opt")
    )
    mark_("cellY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_dot <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "r"),
        status  = c("opt", "opt", "opt")
    )
    mark_("dot", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_dotX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "r"),
        status  = c("opt", "opt", "opt")
    )
    mark_("dotX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_dotY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "r"),
        status  = c("opt", "opt", "opt")
    )
    mark_("dotY", g, channels, ...)
}


#' @rdname mark_area
#' @export
mark_line <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "z"),
        status  = c("req", "req", "opt")
    )
    mark_("line", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_lineX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "z"),
        status  = c("opt", "opt", "opt")
    )
    mark_("lineX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_lineY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",   "z"),
        status  = c("opt", "opt", "opt")
    )
    mark_("lineY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_link <- function(g, ...) {
    channels <- data.frame(
        channel = c("x1",   "y1", "x2",  "y2"),
        status  = c("req", "req", "req", "req")
    )
    mark_("link", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_rect <- function(g, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2"),
        status  = c("req", "req", "req", "req")
    )
    mark_("rect", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_rectX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2",  "x"),
        status  = c("opt", "req", "opt", "req", "opt")
    )
    mark_("rectX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_rectY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x1",  "y1",  "x2",  "y2",  "y"),
        status  = c("req", "opt", "req", "opt", "opt")
    )
    mark_("rectY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_ruleX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y1",  "y2",  "y"),
        status  = c("opt", "opt", "opt", "opt")
    )
    mark_("ruleX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_ruleY <- function(g, ...) {
    channels <- data.frame(
        channel = c("y",   "x1",  "x2",  "x"),
        status  = c("opt", "opt", "opt", "opt")
    )
    mark_("ruleY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_text <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",  "text", "fontSize", "rotate"),
        status  = c("opt", "opt", "req", "opt",      "opt")
    )
    mark_("text", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_textX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",  "text", "fontSize", "rotate"),
        status  = c("opt", "opt", "req", "opt",      "opt")
    )
    mark_("textX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_textY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y",  "text", "fontSize", "rotate"),
        status  = c("opt", "opt", "req", "opt",      "opt")
    )
    mark_("textY", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_tickX <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("req", "opt")
    )
    mark_("textX", g, channels, ...)
}

#' @rdname mark_area
#' @export
mark_tickY <- function(g, ...) {
    channels <- data.frame(
        channel = c("x",   "y"),
        status  = c("opt", "req")
    )
    mark_("textY", g, channels, ...)
}


#' Add a decoration mark to an obsplot
#'
#' @param g an obsplot object
#' @param ... options passed to define the mark
#' @export
mark_frame <- function(g, ...) {
    mark_("frame", g, mark_channels = NULL, ...)
}


mark_ <- function(mark_type, g, mark_channels, ...) {

    opts <- list(...)

    # Get unnamed opts and removed them
    if (is.null(names(opts))) {
        unnamed_opts <- opts
        opts <- list()
    } else {
        unnamed_opts <- opts[names(opts) == ""]
        opts <- opts[names(opts) != ""]
    }

    if (length(unnamed_opts) > 2) stop("a mark cannot accept more than two unnamed arguments")

    # Get transform from unnamed opts
    transform <- Find(
        function(v) inherits(v, "obsplot_transform"),
        unnamed_opts, nomatch = NULL
    )
    # Unless it has been specifically given in named opts
    if (!is.null(opts$transform)) {
        transform <- opts$transform
        opts$transform <- NULL
    }

    # Get data from unnamed opts
    data <- Find(
        function(v) !inherits(v, "obsplot_transform"),
        unnamed_opts, nomatch = NULL
    )

    # Unless it has been specifically given in named opts
    if (!is.null(opts$data)) {
        data <- opts$data
        opts$data <- NULL
    }

    # If x or y channel is a vector and data is null, automatically
    # add a corresponding data index
    if (is.vector(opts$x) && length(opts$x) > 1) {
        if (is.vector(opts$y) && length(opts$x) != length(opts$y)) {
            stop("if x and y are not of the same length")
        }
        if (is.null(data)) data <- seq_along(opts$x)
    }
    if (is.vector(opts$y) && length(opts$y) > 1) {
        if (is.null(data)) data <- seq_along(opts$y)
    }


    # Check channels values
    check_data <- data
    if (is.null(data)) check_data <- g$x$data
    check_channels(
        data = check_data,
        mark_channels = mark_channels,
        mark_opts = opts,
        has_transform = !is.null(transform)
    )

    mark <- list(type = mark_type, data = data, transform = transform, opts = opts)
    g$x$marks <- append(g$x$marks, list(mark))

    g
}