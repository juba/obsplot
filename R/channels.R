# Channels available for every mark
universal_channels <- c("fill", "fillOpacity", "stroke", "strokeOpacity", "strokeWidth", "title")


# Check defined channels
check_mark <- function(data, mark_channels, req_channels, mark_opts, mark_has_data, mark_has_transform) {

    # Check required channels if there is no transform
    if (!mark_has_transform) {
        missing_channels <- setdiff(req_channels, names(mark_opts))
        if (length(missing_channels) >= 1) {
            stop("missing channels ", paste(missing_channels, collapse = ", "))
        }
    }

    ## Check channels that are single character strings
    char_chans <- get_character_channels(mark_opts, mark_channels)

    # Check color channels
    chans <- intersect(char_chans, c("fill", "stroke"))
    for (chan in chans) {
        value <- mark_opts[[chan]]
        if (!(is_css_color(value) || value %in% names(data))) {
            stop(chan, " must be a CSS color or a column of data")
        }
    }

    # Check vector channels
    data_chans <- get_vector_channels(mark_opts, mark_channels)
    if (length(data_chans) >= 1) {
        lengths <- sapply(data_chans, \(chan) length(mark_opts[[chan]]))
        if (mark_has_data && any(lengths > 1)) stop(" can't provide both a data object and data channels")
        lengths <- lengths[lengths > 1]
        if (length(unique(lengths)) > 1) stop(" all data channels must be of the same length or of length 1")
    }

    # Check data column channels
    chans <- setdiff(char_chans, c("fill", "stroke"))
    # Remove data channels to remove single values marked with as_data
    chans <- setdiff(chans, data_chans)
    for (chan in chans) {
        value <- mark_opts[[chan]]
        if (!(value %in% names(data))) stop(chan, " is not a column of data")
    }

}

# Check if a string is a CSS color or equivalent
is_css_color <- function(str) {
    str <- tolower(str)
    str <- gsub("\\s", "", str)
    css_colors <- gsub("\\d", "", grDevices::colors())
    css_colors <- unique(css_colors)
    css_colors <- c(css_colors, "none", "transparent", "currentcolor")
    if (str %in% css_colors) return(TRUE)
    is_hex_code <- grepl("^#[0-9a-f]{6}$", str) || grepl("^#[0-9a-f]{3}$", str)
    return(is_hex_code)
}

# Return channels that are data vectors
get_vector_channels <- function(opts, mark_channels) {
    # Options that are not vector channels when of length 1
    not_vector_length1 <- c(
        "fillOpacity", "strokeOpacity", "r",
        "fontSize", "rotate"
    )
    channels <- get_defined_channels(opts, mark_channels)
    Filter(function(chan) {
        value <- opts[[chan]]
        # Channels explicitly marked as vector
        is_data <- attr(value, "obsplot_is_data")
        if (!is.null(is_data) && is_data) return(TRUE)
        # If channel is radius or opacity and a single number, don't consider it a vector channel
        if (chan %in% not_vector_length1 && length(value) == 1 && is.numeric(value))
            return(FALSE)
        # Else, vectors of size > 1 or vectors of size 1 but not characters
        # are considered as vector channels
        (is.atomic(value) && length(value) > 1) ||
        (is.atomic(value) && !is.character(value)) ||
        inherits(value, "Date") ||
        inherits(value, "POSIXt")
    }, channels)
}

# Return channels that are JS calls
get_js_channels <- function(opts, mark_channels) {
    channels <- get_defined_channels(opts, mark_channels)
    Filter(
        \(chan) inherits(opts[[chan]], "JS_EVAL"),
        channels
    )
}

# Return channels that are character strings
get_character_channels <- function(opts, mark_channels) {
    channels <- get_defined_channels(opts, mark_channels)
    Filter(
        \(chan) is.character(opts[[chan]]) && length(opts[[chan]]) == 1 && !(inherits(opts[[chan]], "JS_EVAL")),
        channels
    )
}

# Return the defined channels names
get_defined_channels <- function(opts, mark_channels) {
    possible_channels <- c(mark_channels, universal_channels)
    intersect(possible_channels, names(opts))
}

