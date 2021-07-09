is_categorical <- function(v) {
    is.character(v) || is.factor(v)
}

is_css_color <- function(str) {
    str <- tolower(str)
    css_colors <- gsub("\\d", "", grDevices::colors())
    css_colors <- unique(css_colors)
    css_colors <- c(css_colors, "none", "transparent")
    if (str %in% css_colors) return(TRUE)
    is_hex_code <- grepl("^#[0-9a-f]{6}$", str) || grepl("^#[0-9a-f]{3}$", str)
    return(is_hex_code)
}

