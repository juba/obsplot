check_channels <- function(data, mark_channels, mark_opts, has_transform) {
    universal_channels <- data.frame(
        channel = c("fill", "fillOpacity", "stroke", "strokeOpacity"),
        status = c("opt", "opt", "opt", "opt")
    )
    channels <- rbind(mark_channels, universal_channels)

    # Check required channels if there is no transform
    if (!has_transform) {
        req <- channels$channel[channels$status == "req"]
        missing_channels <- setdiff(req, names(mark_opts))
        if (length(missing_channels) >= 1) {
            stop("missing channels ", paste(missing_channels, collapse = ", "))
        }
    }

    # Don't check a channel if it is a JS function
    mark_opts_check <- Filter(function(mark_arg) {
        !inherits(mark_arg, "JS_EVAL")
    }, mark_opts)

    opts <- names(mark_opts_check)

    # Check color channels
    chans <- intersect(opts, c("fill", "stroke"))
    for (chan in chans) {
        check_channel_color(data, chan, mark_opts_check[[chan]])
    }

    # Check channels which can be a data column
    chans <- setdiff(opts, c("fill", "stroke", "curve", "textAnchor"))
    for (chan in chans) {
        check_channel_column(data, chan, mark_opts_check[[chan]])
    }

}

check_channel_color <- function(data, chan, value) {
    # If single string, either a CSS color or a column of data
    if (length(value) == 1 && is.character(value)) {
        if (!(is_css_color(value) || value %in% names(data))) {
            stop(chan, " must be a CSS color or a column of data")
        }
    }
}

check_channel_column <- function(data, chan, value) {
    # If single string, must be a column of data
    if (length(value) == 1 && is.character(value)) {
        if (!(value %in% names(data))) stop(chan, " is not a column of data")
    }
}