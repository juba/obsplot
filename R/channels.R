# Channels available for every mark
universal_channels <- c("fill", "fillOpacity", "stroke", "strokeOpacity", "strokeWidth", "title")

# Get CSS color names from grDevices
css_color_names <- gsub("\\d", "", grDevices::colors()) |>
    unique() |>
    append(c("none", "transparent", "currentcolor"))


# Check defined channels
check_mark <- function(
    data, mark_channels, req_channels, 
    vector_channels, mark_opts, mark_has_data, mark_has_transform
) {

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

    # Check data column channels
    chans <- setdiff(char_chans, c("fill", "stroke"))
    for (chan in chans) {
        value <- mark_opts[[chan]]
        if (!(value %in% names(data))) stop(chan, " is not a column of data")
    }

    # Check vector channels
    if (length(vector_channels) >= 1) {
        lengths <- purrr::map_int(vector_channels, length)
        if (mark_has_data && any(lengths > 1)) stop(" can't provide both a data object and vector channels")
        lengths <- lengths[lengths > 1]
        if (length(unique(lengths)) > 1) stop(" all vector channels must be of the same length or of length 1")
    }
}

# Check if a string is a CSS color or equivalent
is_css_color <- function(str) {
    str <- tolower(str)
    str <- gsub("\\s", "", str)
    is_hex_code <- grepl("^#[0-9a-f]{6}$", str) || grepl("^#[0-9a-f]{3}$", str)
    return(is_hex_code || str %in% css_color_names)
}

# Return channels that are data vectors
get_vector_channels <- function(opts, mark_channels) {
    # Options that are not vector channels when of length 1
    not_vector_length1 <- c(
        "fillOpacity", "strokeOpacity", "r",
        "fontSize", "rotate"
    )
    vector_channels <- purrr::keep(
        get_defined_channels(opts, mark_channels),
        \(chan) {
            v <- opts[[chan]]
            # Channels explicitly marked as vector
            is_data <- attr(v, "obsplot_is_data")
            if (!is.null(is_data) && is_data) return(TRUE)
            # If channel is radius or opacity and a single number, don't consider it a vector channel
            if (chan %in% not_vector_length1 && length(v) == 1 && is.numeric(v))
                return(FALSE)
            # Else, vectors of size > 1 or vectors of size 1 but not characters
            # are considered as vector channels
            (is.atomic(v) && length(v) > 1) ||
                (is.atomic(v) && !is.character(v)) ||
                inherits(v, "Date") ||
                inherits(v, "POSIXt")
        }
    )
    if (length(vector_channels) == 0) return(NULL)
    opts[vector_channels]
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
        \(chan) {
            v <- opts[[chan]]
            is.character(v) && length(v) == 1 && !(inherits(v, "JS_EVAL"))
        },
        channels
    )
}

# Return the defined channels names
get_defined_channels <- function(opts, mark_channels) {
    possible_channels <- c(mark_channels, universal_channels)
    intersect(possible_channels, names(opts))
}
