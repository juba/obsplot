#' Add a mark to an obsplot
#'
#' @param g an obsplot object
#' @param ... named options passed to define the mark
#'
#' ... arguments can accept at most two unnamed arguments : a data object and a call
#' to a transform function.
#' @export
mark_area <- function(g, ...) {
    channels <- c("x1", "y1", "x2", "y2", "z")
    req_channels <- c("x1", "y1")
    mark_("area", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_areaX <- function(g, ...) {
    channels <- c("x", "y", "z")
    mark_("areaX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_areaY <- function(g, ...) {
    channels <- c("x", "y", "z")
    mark_("areaY", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_barX <- function(g, ...) {
    channels <- c("x1", "x2", "x", "y")
    mark_("barX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_barY <- function(g, ...) {
    channels <- c("y1", "y2", "x", "y")
    mark_("barY", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_cell <- function(g, ...) {
    channels <- c("x", "y")
    mark_("cell", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_cellX <- function(g, ...) {
    channels <- c("x", "y")
    mark_("cellX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_cellY <- function(g, ...) {
    channels <- c("x", "y")
    mark_("cellY", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_dot <- function(g, ...) {
    channels <- c("x", "y", "r")
    mark_("dot", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_dotX <- function(g, ...) {
    channels <- c("x", "y", "r")
    mark_("dotX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_dotY <- function(g, ...) {
    channels <- c("x", "y", "r")
    mark_("dotY", g, channels, req_channels = NULL, ...)
}


#' @rdname mark_area
#' @export
mark_line <- function(g, ...) {
    channels <- c("x", "y", "z")
    req_channels <- c("x", "y")
    mark_("line", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_lineX <- function(g, ...) {
    channels <- c("x", "y", "z")
    mark_("lineX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_lineY <- function(g, ...) {
    channels <- c("x", "y", "z")
    mark_("lineY", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_link <- function(g, ...) {
    channels <- c("x1", "y1", "x2", "y2")
    req_channels <- c("x1", "y1", "x2", "y2")
    mark_("link", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_rect <- function(g, ...) {
    channels <- c("x1", "y1", "x2", "y2")
    mark_("rect", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_rectX <- function(g, ...) {
    channels <- c("x1", "y1", "x2", "y2", "x", "y")
    mark_("rectX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_rectY <- function(g, ...) {
    channels <- c("x1", "y1", "x2", "y2", "y", "x")
    mark_("rectY", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_ruleX <- function(g, ...) {
    channels <- c("x", "y1", "y2", "y")
    mark_("ruleX", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_ruleY <- function(g, ...) {
    channels <- c("y", "x1", "x2", "x")
    mark_("ruleY", g, channels, req_channels = NULL, ...)
}

#' @rdname mark_area
#' @export
mark_text <- function(g, ...) {
    channels <- c("x", "y", "text", "fontSize", "rotate")
    req_channels <- "text"
    mark_("text", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_textX <- function(g, ...) {
    channels <- c("x", "y", "text", "fontSize", "rotate")
    req_channels <- "text"
    mark_("textX", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_textY <- function(g, ...) {
    channels <- c("x", "y", "text", "fontSize", "rotate")
    req_channels <- "text"
    mark_("textY", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_tickX <- function(g, ...) {
    channels <- c("x", "y")
    req_channels <- "x"
    mark_("tickX", g, channels, req_channels, ...)
}

#' @rdname mark_area
#' @export
mark_tickY <- function(g, ...) {
    channels <- c("x", "y")
    req_channels <- "y"
    mark_("tickY", g, channels, req_channels, ...)
}


#' Add a decoration mark to an obsplot
#'
#' @param g an obsplot object
#' @param fill fill CSS color
#' @param ... options passed to define the mark
#' @export
mark_frame <- function(g, fill = "none", ...) {
    mark_("frame", g, mark_channels = NULL, req_channels = NULL, fill = fill, ...)
}

#' Add an SVG element to an obsplot
#'
#' @param g an obsplot object
#' @param svg SVG to add, as a character string
#' @param ... options passed to define the mark
#' @export

mark_svg <- function(g, svg, ...) {
    f_code <- paste0("() => svg`", svg, "`")
    f <- JS(f_code)
    mark_function(g, f)
}

#' Add a render function mark to an obsplot
#'
#' @param g an obsplot object
#' @param f render function, defined with `htmlwidgets::JS()`
#' @param ... options passed to define the mark
#' @export

mark_function <- function(g, f, ...) {
    mark_("function", g, mark_channels = NULL, req_channels = NULL, fun = f, ...)
}


mark_ <- function(mark_type, g, mark_channels, req_channels, ...) {

    opts <- list(...)

    # Extract unnamed opts and removed them from opts
    if (is.null(names(opts))) {
        unnamed_opts <- opts
        opts <- list()
    } else {
        unnamed_opts <- opts[names(opts) == ""]
        opts <- opts[names(opts) != ""]
    }

    if (length(unnamed_opts) > 2) stop("a mark cannot accept more than two unnamed arguments")

    # Get transform
    transform <- opts$transform %||% Find(
        \(v) inherits(v, "obsplot_transform"),
        unnamed_opts, nomatch = NULL
    )
    opts$transform <- NULL

    # Get data
    data <- opts$data %||% Find(
        \(v) !inherits(v, "obsplot_transform"),
        unnamed_opts, nomatch = NULL
    )
    opts$data <- NULL

    # Check channels values
    check_data <- data %||%  g$x$data$data
    check_mark(
        data = check_data,
        mark_channels = mark_channels,
        req_channels = req_channels,
        mark_opts = opts,
        mark_has_data = !is.null(data),
        mark_has_transform = !is.null(transform)
    )

    # Data channels (vectors)
    vector_channels <- get_vector_channels(opts, mark_channels)

    # Automatically add indexed data argument if needed
    if (length(vector_channels) >= 1 && is.null(data)) {
        lengths <- sapply(vector_channels, \(chan) length(opts[[chan]]))
        max_length <- max(lengths, na.rm = TRUE)
        data <- seq_len(max_length)
    }

    # Add metadata to data channels
    for (chan in vector_channels) {
        if (length(opts[[chan]]) == 1) {
            rep_length <- nrow(data) %||% length(data)
            opts[[chan]] <- rep(opts[[chan]], rep_length)
        }
        if (!is.null(opts[[chan]])) opts[[chan]] <- add_metadata(opts[[chan]])
    }

    # Add metadata to data
    data <- add_metadata(data)

    mark <- list(
        type = mark_type,
        data = data, vector_channels = vector_channels,
        transform = transform, opts = opts
    )
    g$x$marks <- append(g$x$marks, list(mark))

    g
}
