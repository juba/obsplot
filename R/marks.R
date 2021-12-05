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

#' @rdname mark_area
#' @export
mark_image <- function(g, ...) {
    channels <- c("x", "y", "width", "height")
    req_channels <- "y"
    mark_("image", g, channels, req_channels, ...)
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
    f <- JS(f_code) # nolint
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


# Add a mark to a chart object
mark_ <- function(mark_type, g, mark_channels, req_channels, ...) {

    # Keep opts as quosures
    opts <- rlang::enquos(...)
    unnamed_opts <- list()

    # Extract unnamed opts, eval the quosures and remove them from opts
    if (is.null(names(opts))) {
        unnamed_opts <- opts |> purrr::map(rlang::eval_tidy)
        opts <- list()
    } else {
        unnamed_opts <- opts[names(opts) == ""] |> purrr::map(rlang::eval_tidy)
        opts <- opts[names(opts) != ""]
    }

    # Get data
    data <- rlang::eval_tidy(opts$data) %||%
        purrr::detect(unnamed_opts, \(v) !is_transform(v)) # nolint
    opts$data <- NULL
    check_data <- data %||%  g$x$data$data # nolint

    # Get transform
    transform <- rlang::eval_tidy(opts$transform) %||%
        purrr::detect(unnamed_opts, is_transform) # nolint
    opts$transform <- NULL

    # If an opt is a symbol which is a data column name, convert it to a string
    # Otherwise, eval the quosure
    opts <- quosures2opts_data(check_data, opts)

    # Get vector channels and remove them from opts
    vector_channels <- get_vector_channels(opts, mark_channels) # nolint
    opts <- opts[!(names(opts) %in% names(vector_channels))]

    # Get column channels and remove them from opts
    column_channels <- get_column_channels(data, opts, mark_channels) # nolint
    opts <- opts[!(names(opts) %in% names(column_channels))]


    # Check channels values
    check_mark(
        data = check_data,
        mark_channels = mark_channels,
        req_channels = req_channels,
        vector_channels = vector_channels,
        column_channels = column_channels,
        mark_unnamed_opts = unnamed_opts,
        mark_opts = opts,
        mark_has_data = !is.null(data),
        mark_has_transform = !is.null(transform)
    )

    # Automatically add indexed data argument if needed
    if (length(vector_channels) >= 1 && is.null(data) && is.null(column_channels)) {
        lengths <- purrr::map_int(vector_channels, length)
        data <- seq_len(max(lengths, na.rm = TRUE))
    }

    # rep() and add metadata to vector channels
    vector_channels <- purrr::map(
        vector_channels,
        \(v) {
            # rep() if needed
            if (length(v) == 1) {
                rep_length <- nrow(data) %||% length(data) # nolint
                v <- rep(v, rep_length)
            }
            # Add metadata
            add_metadata(v) # nolint
        }
    )

    # Add metadata to data object
    data <- add_metadata(data) # nolint

    # Add mark to chart
    mark <- list(
        type = mark_type,
        data = data,
        vector_channels = vector_channels,
        column_channels = column_channels,
        transform = transform,
        opts = opts
    )

    g$x$marks <- append(g$x$marks, list(mark))

    g
}


# Check mark arguments and channels
check_mark <- function(
    data, mark_channels, req_channels,
    vector_channels, column_channels,
    mark_unnamed_opts, mark_opts,
    mark_has_data, mark_has_transform
) {

    # No more than two unnamed opts
    if (length(mark_unnamed_opts) > 2) {
        stop("a mark cannot accept more than two unnamed arguments")
    }

    # Check required channels if there is no transform
    if (!mark_has_transform) {
        missing_channels <- setdiff(
            req_channels,
            c(names(vector_channels), names(column_channels), names(mark_opts))
        )
        if (length(missing_channels) >= 1) {
            stop("missing channels ", paste(missing_channels, collapse = ", "))
        }
    }

    # Check color channels
    color_chan_names <- intersect(
        get_character_channels(mark_opts, mark_channels),
        c("fill", "stroke")
    )
    for (name in color_chan_names) {
        chan <- mark_opts[[name]]
        if (!(is_css_color(chan) || chan %in% names(data))) {
            stop(name, " must be a CSS color or a column of data")
        }
    }

    # Check column channels
    for (chan in column_channels) {
        if (!(chan %in% names(data))) stop(chan, " is not a column of data")
    }

    # Check vector channels
    if (length(vector_channels) >= 1) {
        lengths <- purrr::map_int(vector_channels, length)
        lengths <- unique(lengths[lengths > 1])
        if (length(lengths) > 1) stop(" all vector channels must be of the same length or of length 1")
    }
}
