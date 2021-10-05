is_categorical <- function(v) {
    is.character(v) || is.factor(v)
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


#' Tells obsplot that a single value is a vector channel, and must be converted to
#' an Array in JavaScript
#'
#' @param x the object to be considered as a vector channel
#'
#' @export
as_data <- function(x) {
  attr(x, "obsplot_is_data") <- TRUE
  x
}

# Convert data object to a list with associated metadata :
# (list of date columns)
add_metadata <- function(data) {
  if (is.null(data)) return(list(data = NULL))

  # If data is JavaScript code, return as is
  if (inherits(data, "JS_EVAL")) {
    return(list(data = data, dates = NULL, type = NULL))
  }

  # If data is a data frame, add date column names to dates
  if (inherits(data, "data.frame")) {
    is_date <- sapply(data, function(v) inherits(v, "Date") || inherits(v, "POSIXt"))
    dates <- names(data)[is_date]
    return(list(data = data, dates = dates, type = "data.frame"))
  }

  # If data is a vector, add TRUE or FALSE to dates
  if (is.atomic(data)) {
    dates <- (inherits(data, "Date") || inherits(data, "POSIXt"))
    if (length(data) == 1) {
      type <- "scalar"
    } else {
      type <- "vector"
    }
    return(list(data = data, dates = dates, type = type))
  }

  # If data is a list
  if (is.list(data)) {
    return(list(data = data, dates = NULL, type = "list"))
  }

  return(list(data = data, dates = NULL, type = NULL))
}

# From a list of quosures, convert single symbols which are not in the
# quosure envoronment to strings and keep the rest as is
quosures2opts_env <- function(opts) {
    purrr::map(opts,
        \(opt) {
            expr <- rlang::quo_get_expr(opt)
            env <- rlang::quo_get_env(opt)
            if (is.symbol(expr)) {
                # If symbol is not defined in its environment,
                # convert to string
                if (!exists(expr, envir = env)) {
                    return(rlang::as_string(expr))
                }
                # If symbol defined but is a function,
                # convert to string
                if (exists(expr, envir = env) && is.function(rlang::eval_tidy(opt))) {
                    return(rlang::as_string(expr))
                }
            }
            rlang::eval_tidy(opt)
        }
    )
}

# If a quosure is a symbol which is a data column name, convert it to a string
# Otherwise, eval the quosure
quosures2opts_data <- function(data, opts) {
    purrr::map(
        opts,
        \(opt) {
            expr <- rlang::quo_get_expr(opt)
            if (is.symbol(expr) && rlang::as_string(expr) %in% names(data))
                return(rlang::as_string(expr))
            rlang::eval_tidy(opt)
        }
    )
}

`%||%` <- function(lhs, rhs) {
  if (!is.null(lhs)) {
    lhs
  } else {
    rhs
  }
}


