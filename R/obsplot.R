#' Create a new obsplot
#' 
#' @param data optional data.frame as primary data source
#' @param width plot width. Use NULL to let Plot decide, or "auto" to let htmlwidgets decide
#' @param height plot height. Use NULL to let Plot decide, or "auto" to let htmlwidgets decide
#' @param menu if TRUE, display a gear menu aside the plot with additional features. Can be set globally with `options("obsplot_menu")`
#' @param elementId optional custom element id, passed to createWidget()
#' @param ... named options passed to Observable Plot
#'
#' @import htmlwidgets
#' @export
obsplot <- function(
  data = NULL,
  width = "auto", height = "auto",
  menu = getOption("obsplot_menu"),
  elementId = NULL, ...) {

  x <- list()

  # forward options using x
  x$data <- add_metadata(data)
  x$opts <- list(...)
  if (is.null(menu)) menu <- FALSE
  x$opts$menu <- menu
  x["marks"] <- list(NULL)

  # If width or height are "auto", put it to Plot opts so that it will use el.width
  # and el.height, and set it to NULL for createWidgets
  x$opts$width <- width
  if (!is.null(width) && width == "auto") width <- NULL
  x$opts$height <- height
  if (!is.null(height) && height == "auto") height <- NULL

  # create widget
  htmlwidgets::createWidget(
    name = 'obsplot',
    x,
    width = width,
    height = height,
    package = 'obsplot',
    elementId = elementId,
    sizingPolicy = htmlwidgets::sizingPolicy(
      browser.fill = TRUE,
      browser.defaultWidth = "100%",
      browser.defaultHeight = "85vh",
      viewer.fill = TRUE,
      viewer.defaultWidth = "100%",
      viewer.defaultHeight = "85vh"
    )
  )
}


#' Shiny bindings for obsplot
#'
#' Output and render functions for using obsplot within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a obsplot
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name obsplot-shiny
#'
#' @export
obsplotOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "obsplot", width, height, package = "obsplot")
}

#' @rdname obsplot-shiny
#' @export
renderObsplot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {  # force quoted
    expr <- substitute(expr)
  }
  htmlwidgets::shinyRenderWidget(expr, obsplotOutput, env, quoted = TRUE)
}
