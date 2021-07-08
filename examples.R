packer::bundle_dev(); devtools::load_all()

library(palmerpenguins)
data(penguins)

obsplot(penguins, grid = TRUE) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, grid = TRUE) |>
    mark_frame(fill = "none") |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "island") |>
    facet(x = "island", y = "species") |>
    opts(grid = FALSE, caption = "Youhou")

obsplot(penguins, grid = TRUE) |>
    mark_frame(fill = "none") |>
    mark_dot(
        x = "bill_length_mm", y = "bill_depth_mm", stroke = "island", 
        filter = JS("d => d.island != 'Dream'")
    ) |>
    facet(x = "island", y = "species") |>
    scale_x(label = "chouchou")

obsplot() |>
    mark_cell(
        penguins,
        transform = transform_group(
            list(fill = "count"),
            list(x = "species", y = "island")
        )
    ) |>
    scale_color(scheme = "RdPu")

obsplot(grid = TRUE) |>
    scale_x(type = "log", domain = c(1, 100000), ticks = 20)


obsplot() |>
    mark_dot(data = 1:10, x = rnorm(10), y = rnorm(10))
