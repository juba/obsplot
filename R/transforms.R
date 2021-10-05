# OUTPUTS AND OPTIONS-----------------------------------------------------

#' Define an Observable Plot transform with outputs and options
#'
#' @param ... transform outputs and options
#' @details the first argument passed to the function is passed as outputs to the JavaScript transform. It can be a single value or a list.
#' @export
transform_bin <- function(...) {
    args <- split_options(...)
    transform_("bin", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_binX <- function(...) {
    args <- split_options(...)
    transform_("binX", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_binY <- function(...) {
    args <- split_options(...)
    transform_("binY", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_group <- function(...) {
    args <- split_options(...)
    transform_("group", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_groupX <- function(...) {
    args <- split_options(...)
    transform_("groupX", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_groupY <- function(...) {
    args <- split_options(...)
    transform_("groupY", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_groupZ <- function(...) {
    args <- split_options(...)
    transform_("groupZ", arg1 = args$arg1, options = args$options)
}

#' @rdname transform_bin
#' @export
transform_map <- function(...) {
    args <- split_options(...)
    transform_("map", arg1 = args$arg1, options = args$options)
}


# MAP AND OPTIONS-----------------------------------------------------

#' Define an Observable Plot transform with map and options
#'
#' @param map a map method name
#' @param ... transform options
#' @export
transform_mapX <- function(map, ...) {
    transform_("mapX", arg1 = map, options = get_options(...))
}

#' @rdname transform_mapX
#' @export
transform_mapY <- function(map, ...) {
    transform_("mapY", arg1 = map, options = get_options(...))
}


# BASIS AND OPTIONS-----------------------------------------------------

#' Define an Observable Plot transform with basis and options
#'
#' @param basis a basis method name
#' @param ... transform options
#' @export
transform_normalizeX <- function(basis = NULL, ...) {
    transform_("normalizeX", arg1 = basis, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_normalizeY <- function(basis = NULL, ...) {
    transform_("normalizeY", arg1 = basis, options = get_options(...))
}


# SPECIFIC AND GENERAL OPTIONS -----------------------------------------

#' Define an Observable Plot transform with two options objects
#'
#' @param spec specific options
#' @param ... transform options
#' @export
transform_windowX <- function(spec = NULL, ...) {
    transform_("windowX", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_windowY <- function(spec = NULL, ...) {
    transform_("windowY", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_stackY <- function(spec = NULL, ...) {
    transform_("stackY", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_stackY1 <- function(spec = NULL, ...) {
    transform_("stackY1", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_stackY2 <- function(spec = NULL, ...) {
    transform_("stackY2", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_stackX <- function(spec = NULL, ...) {
    transform_("stackX", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_stackX1 <- function(spec = NULL, ...) {
    transform_("stackX1", arg1 = spec, options = get_options(...))
}

#' @rdname transform_windowX
#' @export
transform_stackX2 <- function(spec = NULL, ...) {
    transform_("stackX2", arg1 = spec, options = get_options(...))
}


# OPTIONS ONLY ---------------------------------------------------------

#' Define an Observable Plot transform options only
#'
#' @param ... transform options
#' @export

transform_selectFirst <- function(...) {
    transform_("selectFirst", arg1 = NULL, options = get_options(...))
}

#' @rdname transform_selectFirst
#' @export
transform_selectLast <- function(...) {
    transform_("selectLast", arg1 = NULL, options = get_options(...))
}

#' @rdname transform_selectFirst
#' @export
transform_selectMinX <- function(...) {
    transform_("selectMinX", arg1 = NULL, options = get_options(...))
}

#' @rdname transform_selectFirst
#' @export
transform_selectMaxX <- function(...) {
    transform_("selectMaxX", arg1 = NULL, options = get_options(...))
}

#' @rdname transform_selectFirst
#' @export
transform_selectMinY <- function(...) {
    transform_("selectMinY", arg1 = NULL, options = get_options(...))
}

#' @rdname transform_selectFirst
#' @export
transform_selectMaxY <- function(...) {
    transform_("selectMaxY", arg1 = NULL, options = get_options(...))
}



transform_ <- function(transform_type, arg1, options) {
    l <- list(
        transform_type = transform_type,
        arg1 = arg1,
        options = options
    )
    class(l) <- c("obsplot_transform", class(l))
    l
}

# From a list of arguments, returns the first one as arg1 and the rest as options
split_options <- function(...) {
    opts <- rlang::enquos(...) |> quosures2opts_env()
    if (length(opts) == 0) {
        return(list(arg1 = NULL, options = NULL))
    }
    arg1 <- opts[1]
    if (is.list(arg1[[1]])) {
        arg1 <- arg1[[1]]
    }
    options <- opts[-1]
    if (length(options) >= 1 && is.list(options[[1]])) {
        options <- options[[1]]
    }
    return(list(arg1 = arg1, options = options))
}

# Returns the passed arguments as a list, unless the first argument is itself a list.
# In this case, returns the first argument.
get_options <- function(...) {
    options <- rlang::enquos(...) |> quosures2opts_env()
    if (length(options) == 0) {
        return(NULL)
    }
    if (is.list(options[[1]])) {
        options <- options[[1]]
    }
    return(options)
}
