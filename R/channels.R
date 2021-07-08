check_channels <- function(data, mark_channels, mark_args) {
    universal_channels <- data.frame(
        channel = c("fill", "fillOpacity", "stroke", "strokeOpacity"),
        status = c("opt", "opt", "opt", "opt"),
        type = c("color", "opacity", "color", "opacity")
    )
    channels <- rbind(mark_channels, universal_channels)

    # Is there a transform argument ?
    has_transform <- !is.null(mark_args[["transform"]])

    # Check required channels
    if (!has_transform) {
        req <- channels$channel[channels$status == "req"]
        missing_channels <- setdiff(req, names(mark_args))
        if (length(missing_channels) > 1) {
            stop("missing channels ", paste(missing_channels, collapse = ", "))
        }
    }

    # Don't check a channel if it is a JS function
    mark_args <- Filter(function(mark_arg) {
        !inherits(mark_arg, "JS_EVAL")
    }, mark_args)

    args <- names(mark_args)

    # Check numeric channels
    chans <- intersect(args, channels$channel[channels$type == "num"])
    for (chan in chans) {
        check_channel_numeric(data, chan, mark_args[[chan]])
    }

    # Check categorical channels
    chans <- intersect(args, channels$channel[channels$type == "cat"])
    for (chan in chans) {
        check_channel_categorical(data, chan, mark_args[[chan]])
    }

    # Check color channels
    chans <- intersect(args, channels$channel[channels$type == "color"])
    for (chan in chans) {
        check_channel_color(data, chan, mark_args[[chan]])
    }

    # Check opacity channels
    chans <- intersect(args, channels$channel[channels$type == "opacity"])
    for (chan in chans) {
        check_channel_opacity(data, chan, mark_args[[chan]])
    }

    # Check radius channels
    chans <- intersect(args, channels$channel[channels$type == "radius"])
    for (chan in chans) {
        check_channel_radius(data, chan, mark_args[[chan]])
    }
}


check_channel_numeric <- function(data, chan, value) {
    # Numeric vector
    if (length(value) > 1 && !is.numeric(value)) {
        stop(chan, " must be numeric")
    }
    # Numeric column of data
    if (length(value) == 1) {
        if (!(value %in% names(data))) stop(chan, " must be a column of data")
        if ((value %in% names(data)) && !is.numeric(data[[value]])) {
            stop(chan, " must be a numeric column of data")
        }
    }
}

check_channel_categorical <- function(data, chan, value) {
    # Categorical vector
    if (length(value) > 1 && !is_categorical(value)) {
        stop(chan, " must be categorical")
    }
    # Categorical column of data
    if (length(value) == 1) {
        if (!(value %in% names(data))) stop(chan, " must be a column of data")
        if ((value %in% names(data)) && !is_categorical(data[[value]])) {
            stop(chan, " must be a categorical column of data")
        }
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

check_channel_opacity <- function(data, chan, value) {
    # If single string, must be a column of data
    if (length(value) == 1 && is.character(value)) {
        if (!(value %in% names(data))) stop(chan, " must be a column of data")
    }
}

check_channel_radius <- function(data, chan, value) {
    # If single string, must be a column of data
    if (length(value) == 1 && is.character(value)) {
        if (!(value %in% names(data))) stop(chan, " must be a column of data")
    }
}