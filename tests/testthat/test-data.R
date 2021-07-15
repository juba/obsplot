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
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:5, dates = FALSE))
})

test_that("date / time metadata", {
  expect_equal(g$x$data$dates, c("date", "time"))
  g2 <- g |> mark_dot(data_mark, x = "datem")
  expect_equal(g2$x$marks[[1]]$data$dates, c("datem", "timem"))
  g2 <- g |> mark_dot(data_mark, x = "datem")
  expect_equal(g2$x$marks[[1]]$data$dates, c("datem", "timem"))
  g2 <- g |> mark_dot(x = 1:5)
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:5, dates = FALSE))
  expect_equal(g2$x$marks[[1]]$opts$x, list(data = 1:5, dates = FALSE))
  g2 <- g |> mark_dot(x = c("foo", "bar"))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:2, dates = FALSE))
  expect_equal(g2$x$marks[[1]]$opts$x, list(data = c("foo", "bar"), dates = FALSE))
  g2 <- g |> mark_dot(x = c("foo", "bar"), y = as.Date(c("2000-01-01", "2100-01-01")), z = 3:4)
  expect_equal(g2$x$marks[[1]]$data, list(data = 1:2, dates = FALSE))
  expect_equal(g2$x$marks[[1]]$opts$y, list(data = as.Date(c("2000-01-01", "2100-01-01")), dates = TRUE))
  # No converstion if not a mark channel
  expect_equal(g2$x$marks[[1]]$opts$z, 3:4)
  g2 <- g |> mark_dot(x = 3, r = as.Date(c("2000-01-01")))
  expect_equal(g2$x$marks[[1]]$data, list(data = 1, dates = FALSE))
  expect_equal(g2$x$marks[[1]]$opts$x, list(data = 3, dates = FALSE))
  expect_equal(g2$x$marks[[1]]$opts$r, list(data = as.Date(c("2000-01-01")), dates = TRUE))
})