is_categorical <- function(v) {
    is.character(v) || is.factor(v)
}

is_css_color <- function(str) {
    str <- tolower(str)
    css_colors <- gsub("\\d", "", grDevices::colors())
    css_colors <- unique(css_colors)
    css_colors <- c(css_colors, "none", "transparent", "currentcolor")
    if (str %in% css_colors) return(TRUE)
    is_hex_code <- grepl("^#[0-9a-f]{6}$", str) || grepl("^#[0-9a-f]{3}$", str)
    return(is_hex_code)
}


#' Convert a Date or POSIXt object to a JS Date format
#'
#' @param date object to be converted
#'
#' @return
#' Numeric value representing the number of milliseconds between Unix Epoch
#' (1 January 1970 UTC) and `date`.
#'
#' @export
#'
to_js_date <- function(date) {
  ## Code taken from lubridate::origin
  diff <- as.POSIXct(date) - structure(0, class = c("POSIXct", "POSIXt"), tzone = "UTC")
  as.numeric(diff, unit = "secs") * 1000
}


#' Convert data object to a list with associated metadata : 
#' (list of date columns)
add_metadata <- function(data) {
  if (is.null(data)) return(list(data = NULL))
  # If data is a data frame, add date column names to dates
  if (inherits(data, "data.frame")) {
    is_date <- sapply(data, function(v) inherits(v, "Date") || inherits(v, "POSIXt"))
    dates <- names(data)[is_date]
    return(list(data = data, dates = dates))
  }
  # If data is a vector, add TRUE or FALSE to dates
  if (is.atomic(data)) {
    dates <- (inherits(data, "Date") || inherits(data, "POSIXt"))
    return(list(data = data, dates = dates))
  }
  return(list(data = data, dates = NULL))
}


