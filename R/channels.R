# Check defined channels
check_channels <- function(check_data, data, mark_channels, mark_opts, has_transform) {

    channels <- rbind(mark_channels, universal_channels())

    # Check required channels if there is no transform
    if (!has_transform) {
        req <- channels$channel[channels$status == "req"]
        missing_channels <- setdiff(req, names(mark_opts))
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
        if (!(is_css_color(value) || value %in% names(check_data))) {
            stop(chan, " must be a CSS color or a column of data")
        }
    }

    # Check data column channels
    chans <- setdiff(char_chans, c("fill", "stroke"))
    for (chan in chans) {
        value <- mark_opts[[chan]]
        if (!(value %in% names(check_data))) stop(chan, " is not a column of data")
    }

    # Check data channels
    data_chans <- get_data_channels(mark_opts, mark_channels)
    if (length(data_chans) >= 1) {
        if (!is.null(data)) stop(" can't provide both a data object and data channels")
        lengths <- sapply(data_chans, function(chan) length(mark_opts[[chan]]))
        if (length(unique(lengths)) > 1) stop(" all data channels must be of the same length")
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
get_data_channels <- function(opts, mark_channels) {
    channels <- get_defined_channels(opts, mark_channels)
    # data channel : vector either of size > 1, or not a single character
    Filter(function(chan) {
        (is.atomic(opts[[chan]]) && length(opts[[chan]]) > 1) ||
        (is.atomic(opts[[chan]]) && !is.character(opts[[chan]])) ||
        inherits(opts[[chan]], "Date") ||
        inherits(opts[[chan]], "POSIXt")
    }, channels)
}

# Return channels that are JS calls
get_js_channels <- function(opts, mark_channels) {
    channels <- get_defined_channels(opts, mark_channels)
    Filter(function(chan) {
        inherits(opts[[chan]], "JS_EVAL")
    }, channels)
}

# Return channels that are character strings
get_character_channels <- function(opts, mark_channels) {
    channels <- get_defined_channels(opts, mark_channels)
    Filter(function(chan) {
        is.character(opts[[chan]]) && length(opts[[chan]]) == 1
    }, channels)
}

# Return the names of the defined channels
get_defined_channels <- function(opts, mark_channels) {
    channels_list <- rbind(mark_channels, universal_channels())
    intersect(channels_list$channel, names(opts))
}

# Channels available for every mark
universal_channels <- function() {
    data.frame(
        channel = c("fill", "fillOpacity", "stroke", "strokeOpacity"),
        status = c("opt", "opt", "opt", "opt")
    )
}