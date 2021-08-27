#' Define an Observable Plot transform with outputs and options
#'
#' @param ... transform outputs and options
#' @details transform output is given as first named argument of the function. If there are several outputs, pass a named list as first argument.
#' @export
transform_bin <- function(...) {
    args <- get_outputs_options(...)
    transform_("bin", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_binX <- function(...) {
    args <- get_outputs_options(...)
    transform_("binX", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_binY <- function(...) {
    args <- get_outputs_options(...)
    transform_("binY", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_group <- function(...) {
    args <- get_outputs_options(...)
    transform_("group", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_groupX <- function(...) {
    args <- get_outputs_options(...)
    transform_("groupX", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_groupY <- function(...) {
    args <- get_outputs_options(...)
    transform_("groupY", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_groupZ <- function(...) {
    args <- get_outputs_options(...)
    transform_("groupZ", args$outputs, args$options)
}

#' @rdname transform_bin
#' @export
transform_map <- function(...) {
    args <- get_outputs_options(...)
    transform_("map", args$outputs, args$options)
}

#' Define an Observable Plot transform with map and options
#'
#' @param map a map method name
#' @param ... transform options
#' @export
transform_mapX <- function(map, ...) {
    transform_("mapX", outputs = map, options = get_options(...))
}

#' @rdname transform_mapX
#' @export
transform_mapY <- function(map, ...) {
    transform_("mapY", outputs = map, options = get_options(...))
}

#' Define an Observable Plot transform with options only
#'
#' @param ... transform options
#' @export
transform_normalizeX <- function(...) {
    transform_("normalizeX", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_normalizeY <- function(...) {
    transform_("normalizeY", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_windowX <- function(...) {
    transform_("windowX", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_windowY <- function(...) {
    transform_("windowY", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_selectFirst <- function(...) {
    transform_("selectFirst", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_selectLast <- function(...) {
    transform_("selectLast", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_selectMinX <- function(...) {
    transform_("selectMinX", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_selectMaxX <- function(...) {
    transform_("selectMaxX", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_selectMinY <- function(...) {
    transform_("selectMinY", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_selectMaxY <- function(...) {
    transform_("selectMaxY", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_stackY <- function(...) {
    transform_("stackY", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_stackY1 <- function(...) {
    transform_("stackY1", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_stackY2 <- function(...) {
    transform_("stackY2", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_stackX <- function(...) {
    transform_("stackX", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_stackX1 <- function(...) {
    transform_("stackX1", outputs = NULL, options = get_options(...))
}

#' @rdname transform_normalizeX
#' @export
transform_stackX2 <- function(...) {
    transform_("stackX2", outputs = NULL, options = get_options(...))
}


transform_ <- function(transform_type, outputs, options) {
    l <- list(
        transform_type = transform_type,
        outputs = outputs,
        options = options
    )
    class(l) <- c("obsplot_transform", class(l))
    l
}

# From a list of arguments, returns the first one as output and the rest as options
get_outputs_options <- function(...) {
    opts <- list(...)
    if (length(opts) == 0) {
        return(list(outputs = list(), options = list()))
    }
    outputs <- opts[1]
    if (is.list(outputs[[1]])) {
        outputs <- outputs[[1]]
    }
    options <- opts[-1]
    if (length(options) >= 1 && is.list(options[[1]])) {
        options <- options[[1]]
    }
    return(list(outputs = outputs, options = options))
}

# Returns the passed arguments as a list, unless the first argument is itself a list.
# In this case, returns the first argument.
get_options <- function(...) {
    options <- list(...)
    if (length(options) == 0) {
        return(list())
    }
    if (is.list(options[[1]])) {
        options <- options[[1]]
    }
    return(options)
}