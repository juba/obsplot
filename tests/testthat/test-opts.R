

test_that("width and height in opts are ignored", {
    expect_warning(g <- obsplot() |> opts(width = 200, grid = TRUE))
    expect_equal(g$x$opts$width, "auto")
    expect_warning(g <- obsplot() |> opts(height = 400, grid = TRUE))
    expect_equal(g$x$opts$height, "auto")
})