data <- data.frame(
  v1 = 1:3,
  v2 = LETTERS[1:3]
)

data_mark <- data.frame(
  v3 = 4:6,
  v4 = LETTERS[4:6]
)

g <- obsplot(data)

test_that("unnamed opts", {
  expect_error(g |> mark_dot(1, 2, 3), "cannot accept more than two unnamed arguments")
  expect_equal((g |> mark_dot(data_mark, x = "v3"))$x$data, list(data = data, dates = character(0), type = "data.frame"))
  g2 <- g |> mark_dot(data_mark, transform_group(x = "sum", x = "v1"))
  expect_equal(g2$x$marks[[1]]$transform$transform_type, "group")
  expect_equal(g2$x$marks[[1]]$data, list(data = data_mark, dates = character(0), type = "data.frame"))
  g2 <- g |> mark_dot(transform_group(x = "sum", x = "v1"), data_mark)
  expect_equal(g2$x$marks[[1]]$transform$transform_type, "group")
  expect_equal(g2$x$marks[[1]]$data, list(data = data_mark, dates = character(0), type = "data.frame"))
  g2 <- g |> mark_dot(transform_group(x = "sum", x = "v1"))
  expect_equal(g2$x$marks[[1]]$transform$transform_type, "group")
  expect_equal(g2$x$marks[[1]]$data, list(data = NULL))
  g2 <- g |> mark_dot(data_mark)
  expect_null(g2$x$marks[[1]]$transform)
  expect_equal(g2$x$marks[[1]]$data, list(data = data_mark, dates = character(0), type = "data.frame"))
})

test_that("required channels", {
  expect_error(g |> mark_line(x = "v1"), "missing channels y")
  expect_error(g |> mark_line(transform_group(x = "sum", x = "v1")), NA)
})

test_that("color and column channels", {
  expect_error(g |> mark_dot(x = "v3"), "is not a column of data")
  expect_error(g |> mark_dot(x = "v1"), NA)
  expect_error(g |> mark_dot(z = "v1"), NA)
  expect_error(g |> mark_dot(fill = "v3"), "must be a CSS color or a column")
  expect_error(g |> mark_dot(data_mark, x = "v1"), "is not a column of data")
  expect_error(g |> mark_dot(data_mark, x = "v3"), NA)
  expect_error(g |> mark_dot(x = "v1", y = "darkblue"), "is not a column of data")
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = "v2"), NA)
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = "darkblue"), NA)
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = " Transparent  "), NA)
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = "currentColor"), NA)
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = "#A23"), NA)
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = "#A87654"), NA)
  expect_error(g |> mark_dot(x = "v1", y = "v2", fill = "#55G"), "must be a CSS color or a column")
  expect_error(g |> mark_dot(x = JS("v87"), y = JS("v200"), fill = "red"), NA)
})

test_that("data channels", {
  expect_error(g |> mark_dot(data, x = 1:5, y = 1:5), "can't provide both a data object and data channels")
  expect_error(g |> mark_dot(x = 1:6, y = 1:5), "all data channels must be of the same length")
  g2 <- g |> mark_dot(x = 1:5, y = 1:5)
  expect_equal(g2$x$marks[[1]]$vector_channels, c("x", "y"))
  g2 <- g |> mark_dot(x = 1, r = 1:5)
  expect_equal(g2$x$marks[[1]]$vector_channels, c("x", "r"))
  g2 <- g |> mark_dot(x = 1, y = 2)
  expect_equal(g2$x$marks[[1]]$vector_channels, c("x", "y"))
  expect_error(g |> mark_dot(x = c("a", "b"), y = c("d", "e")), NA)
  expect_error(g |> mark_dot(x = "a", y = "d"), "is not a column of data")
  # Single numerical r, strokeOpacity or fillOpacity are not data channels
  g2 <- g |> mark_dot(x = 1:5, y = 2, fillOpacity = 0.5, strokeOpacity = 10, fill = 2, r = 100)
  expect_equal(g2$x$marks[[1]]$vector_channels, c("x", "y", "fill"))
  g2 <- g |> mark_dot(x = 1:5, y = 2, fillOpacity = 1:5, strokeOpacity = 1:5, r = 2:6, fill = 2)
  expect_equal(g2$x$marks[[1]]$vector_channels, c("x", "y", "r", "fill", "fillOpacity", "strokeOpacity"))
})
