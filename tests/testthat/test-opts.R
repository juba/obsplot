

test_that("width and height in opts are ignored", {
    expect_warning(g <- obsplot() |> opts(width = 200, grid = TRUE))
    expect_equal(names(g$x$opts), "grid")
    expect_warning(g <- obsplot() |> opts(height = 400, grid = TRUE))
    expect_equal(names(g$x$opts), "grid")
})