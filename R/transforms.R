#' Define an Observable Plot transform with outputs and options
#'
#' @param outputs a named list of outputs
#' @param options a named list of options
#' @export
transform_bin <- function(outputs, options) {
    transform_("bin", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_binX <- function(outputs, options) {
    transform_("binX", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_binY <- function(outputs, options) {
    transform_("binY", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_group <- function(outputs, options) {
    transform_("group", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_groupX <- function(outputs, options) {
    transform_("groupX", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_groupY <- function(outputs, options) {
    transform_("groupY", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_groupZ <- function(outputs, options) {
    transform_("groupZ", outputs, options)
}

#' @rdname transform_bin
#' @export
transform_map <- function(outputs, options) {
    transform_("map", outputs, options)
}

#' Define an Observable Plot transform with map and options
#'
#' @param map a map method name
#' @param options a named list of options
#' @export
transform_mapX <- function(map, options) {
    transform_("mapX", outputs = map, options = options)
}

#' @rdname transform_mapX
#' @export
transform_mapY <- function(map, options) {
    transform_("mapY", outputs = map, options = options)
}

#' Define an Observable Plot transform with options only
#'
#' @param options a named list of options
#' @export
transform_normalizeX <- function(options) {
    transform_("normalizeX", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_normalizeY <- function(options) {
    transform_("normalizeY", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_windowX <- function(options) {
    transform_("windowX", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_windowY <- function(options) {
    transform_("windowY", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_selectFirst <- function(options) {
    transform_("selectFirst", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_selectLast <- function(options) {
    transform_("selectLast", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_selectMinX <- function(options) {
    transform_("selectMinX", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_selectMaxX <- function(options) {
    transform_("selectMaxX", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_selectMinY <- function(options) {
    transform_("selectMinY", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_selectMaxY <- function(options) {
    transform_("selectMaxY", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_stackY <- function(options) {
    transform_("stackY", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_stackY1 <- function(options) {
    transform_("stackY1", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_stackY2 <- function(options) {
    transform_("stackY2", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_stackX <- function(options) {
    transform_("stackX", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_stackX1 <- function(options) {
    transform_("stackX1", outputs = NULL, options = options)
}

#' @rdname transform_normalizeX
#' @export
transform_stackX2 <- function(options) {
    transform_("stackX2", outputs = NULL, options = options)
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