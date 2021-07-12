packer::bundle_dev(); devtools::load_all()

library(obsplot)
library(tidyverse)
library(palmerpenguins)
data(penguins)

obsplot(penguins, grid = TRUE) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(grid = TRUE) |>
    mark_dot(penguins, x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, grid = TRUE) |>
    mark_frame(fill = "none") |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "island") |>
    facet(x = "island", y = "species") |>
    opts(grid = FALSE, caption = "What a caption")

obsplot(penguins, grid = TRUE) |>
    mark_frame(fill = "none") |>
    mark_dot(
        x = "bill_length_mm", y = "bill_depth_mm", stroke = "island", 
        filter = JS("d => d.island != 'Dream'")
    ) |>
    facet(x = "island", y = "species") |>
    scale_x(label = "custom x label")

obsplot() |>
    mark_cell(
        transform_group(
            fill = "count",
            x = "species", y = "island"
        ),
        penguins
    ) |>
    scale_color(scheme = "RdPu")

obsplot(grid = TRUE) |>
    scale_x(type = "log", domain = c(1, 100000), ticks = 20)

obsplot() |>
    mark_dot(x = rnorm(10), y = rnorm(10))

obsplot() |>
    mark_line(x = rnorm(10), y = rnorm(10))

obsplot() |>
    mark_areaY(data = cumsum(rnorm(600)))

obsplot() |>
    mark_areaY(y = cumsum(rnorm(600)))

obsplot() |>
    mark_dotX(data = rnorm(100))

obsplot() |>
    mark_dotX(x = runif(100))

obsplot() |>
    mark_dotY(y = runif(100))






## Diamonds example from https://observablehq.com/@observablehq/plot-dot

data(diamonds)
obsplot(diamonds, grid = TRUE) |>
    mark_dot(transform_bin(
        r = "count", x = "carat", y = "price", thresholds = 100
    )) |>
    scale_r(range = c(0, 20))


# width and height

obsplot(penguins, grid = TRUE) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, grid = TRUE, width = 900, height = 800) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, grid = TRUE, width = "auto", height = "auto") |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")
