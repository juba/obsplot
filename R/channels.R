check_channels <- function(data, mark_channels, mark_opts) {
    universal_channels <- data.frame(
        channel = c("fill", "fillOpacity", "stroke", "strokeOpacity"),
        status = c("opt", "opt", "opt", "opt"),
        type = c("color", "", "color", "")
    )
    channels <- rbind(mark_channels, universal_channels)

    # Is there a transform argument ?
    has_transform <- !is.null(mark_opts[["transform"]])

    # Check required channels
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
    chans <- intersect(opts, channels$channel[channels$type == "color"])
    for (chan in chans) {
        check_channel_color(data, chan, mark_opts_check[[chan]])
    }

    # Check other channels
    chans <- intersect(opts, channels$channel[channels$type != "color"])
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