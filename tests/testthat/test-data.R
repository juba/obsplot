data <- data.frame(
  v1 = 1:3,
  date = as.Date(c("2021-10-15", "2034-12-01", "1969-02-18")),
  time = as.POSIXct(c("2021-07-15 15:07:18 CEST", "2021-07-15 15:17:18 CEST", "2021-07-16 10:07:18 CEST"))
)

data_mark <- data.frame(
  v1m = 1:3,
  datem = as.Date(c("2021-10-15", "2034-12-01", "1969-02-18")),
  timem = as.POSIXct(c("2021-07-15 15:07:18 CEST", "2021-07-15 15:17:18 CEST", "2021-07-16 10:07:18 CEST"))
)


g <- obsplot(data)

test_that("add index data", {
  g2 <- g |> mark_dot(x = rnorm(5), y = rnorm(5))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:5, dates = FALSE, type = "vector"))
})

test_that("rep data channels", {
  g2 <- g |> mark_dot(x = 1.2, y = rnorm(5))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:5, dates = FALSE, type = "vector"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x, list(data = rep(1.2, 5), dates = FALSE, type = "vector"))
  # Single numerical r, strokeOpacity or fillOpacity are not data channels
  g2 <- g |> mark_dot(x = 1.2, y = rnorm(5), strokeOpacity = 0.5, fillOpacity = 0, r = 10)
  expect_equal(g2$x$marks[[1]]$opts$strokeOpacity, 0.5)
  expect_equal(g2$x$marks[[1]]$opts$fillOpacity, 0)
  expect_equal(g2$x$marks[[1]]$opts$r, 10)
})

test_that("date / time metadata", {
  expect_equal(g$x$data$dates, c("date", "time"))
  g2 <- g |> mark_dot(data_mark, x = "datem")
  expect_equal(g2$x$marks[[1]]$data$dates, c("datem", "timem"))
  g2 <- g |> mark_dot(data_mark, x = "datem")
  expect_equal(g2$x$marks[[1]]$data$dates, c("datem", "timem"))
  g2 <- g |> mark_dot(x = 1:5)
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:5, dates = FALSE, type = "vector"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x, list(data = 1:5, dates = FALSE, type = "vector"))
  g2 <- g |> mark_dot(x = c("foo", "bar"))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:2, dates = FALSE, type = "vector"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x, list(data = c("foo", "bar"), dates = FALSE, type = "vector"))
  g2 <- g |> mark_dot(x = c("foo", "bar"), y = as.Date(c("2000-01-01", "2100-01-01")), z = 3:4)
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:2, dates = FALSE, type = "vector"))
  expect_equal(g2$x$marks[[1]]$vector_channels$y, list(data = as.Date(c("2000-01-01", "2100-01-01")), dates = TRUE, type = "vector"))
  # No converstion if not a mark channel
  expect_null(g2$x$marks[[1]]$vector_channels$z)
  expect_equal(g2$x$marks[[1]]$opts$z, 3:4)
  g2 <- g |> mark_dot(x = 3, r = as.Date(c("2000-01-01")))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1, dates = FALSE, type = "scalar"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x, list(data = 3, dates = FALSE, type = "scalar"))
  expect_equal(g2$x$marks[[1]]$vector_channels$r, list(data = as.Date(c("2000-01-01")), dates = TRUE, type = "scalar"))
  g2 <- g |> mark_dot(x = 1:10, r = as.Date(c("2000-01-01")))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:10, dates = FALSE, type = "vector"))
  expect_equal(g2$x$marks[[1]]$vector_channels$r, list(data = rep(as.Date(c("2000-01-01")), 10), dates = TRUE, type = "vector"))
})

test_that("data types", {
  g2 <- g |> mark_dot(x = 1)
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "scalar")
  g2 <- g |> mark_dot(x = as.Date("2021-01-05"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "scalar")
  g2 <- g |> mark_dot(x = as.POSIXct("2021-07-15 15:07:18 CEST"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "scalar")
  g2 <- g |> mark_dot(x = 1:3)
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "vector")
  g2 <- g |> mark_dot(x = c("foo", "bar"))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "vector")
  g2 <- g |> mark_dot(x = as.Date(c("2021-10-15", "2034-12-01")))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "vector")
  g2 <- g |> mark_dot(x = as.POSIXct(c("2021-07-15 15:07:18 CEST", "2021-07-15 15:17:18 CEST")))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, "vector")
  g2 <- g |> mark_dot(data = list(x = 1))
  expect_equal(g2$x$marks[[1]]$data$type, "list")
  g2 <- g |> mark_dot(x = list(foo = 1))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, NULL)
  g2 <- g |> mark_dot(data = data.frame(x = 1:3))
  expect_equal(g2$x$marks[[1]]$data$type, "data.frame")
  g2 <- g |> mark_dot(x = data.frame(x = 1:3))
  expect_equal(g2$x$marks[[1]]$vector_channels$x$type, NULL)
  g2 <- g |> mark_dot(JS("d3.cumsum({length: 3}, d3.randomNormal())"))
  expect_equal(g2$x$marks[[1]]$vector_channels$type, NULL)
})