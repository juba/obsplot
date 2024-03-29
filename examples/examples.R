packer::bundle_dev(); devtools::load_all()

library(obsplot)
library(tidyverse)
library(palmerpenguins)
data(penguins)

obsplot(penguins) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot() |>
    mark_dot(penguins, x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, grid = TRUE) |>
    mark_frame() |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "island") |>
    facet(x = "island", y = "species") |>
    opts(grid = FALSE, caption = "What a caption")

obsplot(penguins) |>
    mark_frame() |>
    mark_dot(
        x = "bill_length_mm", y = "bill_depth_mm", stroke = "island", 
        filter = JS("d => d.island != 'Dream'")
    ) |>
    facet(x = "island", y = "species") |>
    scale_x(label = "custom x label") |>
    opts(grid = TRUE)

obsplot() |>
    mark_cell(
        transform_group(
            fill = "count",
            x = "species", y = "island"
        ),
        penguins
    ) |>
    scale_color(scheme = "RdPu")

obsplot() |>
    scale_x(type = "log", domain = c(1, 100000), ticks = 20) |>
    opts(grid = TRUE)

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


# width and height

obsplot(penguins) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, width = 900, height = 800) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")

obsplot(penguins, width = "auto", height = "auto") |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")


# date and time

df <- data.frame(
    date1 = as.Date(c("2021-07-13", "2022-08-14", "2022-10-11")),
    date2 = as.POSIXct(c("2021-07-13 23:46:13 CEST", "2021-07-13 23:47:13 CEST", "2021-07-13 23:48:13 CEST")),
    x = 1:3
)

obsplot(df) |>
    mark_dot(x = "date1", y = "x")
obsplot(df) |>
    mark_dot(x = "date2", y = "x")
obsplot() |>
    mark_dot(x = df$date1, y = df$x, strokeOpacity = 0.1)
obsplot() |>
    mark_dot(x = as.Date("2021-07-13"), y = as.POSIXct("2021-07-13 23:46:13 CEST"))
obsplot() |>
    mark_dot(x = 1, y = as.POSIXct("2021-07-13 23:46:13 CEST"))
obsplot() |>
    mark_dot(x = 1:10, y = as.POSIXct("2021-07-13 23:46:13 CEST"), fill = "red", fillOpacity = .1)

obsplot() |>
        mark_lineY(JS("d3.cumsum({length: 10}, d3.randomNormal())"))
obsplot() |>
    mark_text(
        data = data.frame(
            x = runif(10),
            y = runif(10),
            text = 1:10),
            x = "x", y = "y",
            text = JS("d => d3.format('+.0%')(d.text)"
        )
    )
