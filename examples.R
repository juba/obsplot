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
            list(fill = "count"),
            list(x = "species", y = "island")
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



## gistemp example from https://observablehq.com/@observablehq/plot-dot

gistemp <- read_csv("https://static.observableusercontent.com/files/bc7c1ea172d2e7ecb638dd379cc35232e80e272e668b3e8fee27378d5ab67f6be881ba9608040b699ffc3262cebbddd5defa9dcfbacd917353523c39f4972c67?response-content-disposition=attachment%3Bfilename*%3DUTF-8%27%27gistemp.csv")

gistemp$Datejs <- to_js_date(gistemp$Date)

obsplot(gistemp) |>
    mark_ruleY(y = 0) |>
    mark_dot(x = "Datejs", y = "Anomaly", stroke = "Anomaly") |>
    scale_y(tickFormat = "+f", grid = TRUE) |>
    scale_x(type = "utc") |>
    scale_color(type = "diverging", scheme = "BuRd")



## Driving example from https://observablehq.com/@observablehq/plot-dot

driving <- read_csv("https://static.observableusercontent.com/files/f41c1a1f4d1361c3738d427f1bbdbfaa9e5c651f8bec0902b876bda70ed1801a5aa8f487f53b2cd9bfa94fc40b874e54f4659e58d88044cdde1919cd5eebe8ac?response-content-disposition=attachment%3Bfilename*%3DUTF-8%27%27driving.csv")

driv5 <- driving |> filter(year %% 5 == 0)
obsplot(driving) |>
    mark_line(x = "miles", y = "gas", curve = "catmull-rom") |>
    mark_dot(x = "miles", y = "gas", fill = "currentColor") |>
    mark_text(driv5, x = "miles", y = "gas", text = "year", dy = -8) |>
    opts(grid = TRUE)


## Diamonds example from https://observablehq.com/@observablehq/plot-dot

data(diamonds)
obsplot(diamonds, grid = TRUE) |>
    mark_dot(transform_bin(
        list(r = "count"), list(x = "carat", y = "price", thresholds = 100)
    )) |>
    scale_r(range = c(0, 20))


## Alphabet example from https://observablehq.com/@observablehq/plot-dot

alphabet <- read_csv("https://static.observableusercontent.com/files/75d52e6c3130b1cae83cda89305e17b50f33e7420ef205587a135e8562bcfd22e483cf4fa2fb5df6dff66f9c5d19740be1cfaf47406286e2eb6574b49ffc685d?response-content-disposition=attachment%3Bfilename*%3DUTF-8%27%27alphabet.csv")

obsplot(alphabet) |>
    mark_ruleY(y = 0) |>
    mark_ruleX(x = "letter", y = "frequency") |>
    mark_dot(x = "letter", y = "frequency", fill = "black", r = 4) |>
    scale_x(label = NULL, tickSize = 0) |>
    scale_y(transform = JS("d => d * 100"), label = "↑ Frequency (%)")


## State age example from https://observablehq.com/@observablehq/plot-dot

stateage <- read_csv("https://static.observableusercontent.com/files/81d7bd5e9551f005d7a4764e2dcb46c44f04b5918551ce19dba191a8799b498beddb5ef2da994047586fc7231749e8911c825b1967f22814a57bee58c590c86e?response-content-disposition=attachment%3Bfilename*%3DUTF-8%27%27us-population-state-age.csv")
stateage <- stateage |> 
    pivot_longer(!name, names_to = "age", values_to = "population")

xy <- transform_normalizeY(list(basis = "sum", z = "name", x = "age", y = "population"))
obsplot(stateage) |>
    mark_ruleY(y = 0) |>
    mark_line(
        xy,
        strokeWidth = 1, stroke = "#ccc"
    ) |>
    mark_dot(xy) |>
    scale_x(domain = unique(stateage$age), labelAnchor = "right") |>
    scale_y(transform = JS("d => d*100")) |>
    opts(grid = TRUE)

# width and height

obsplot(penguins, grid = TRUE, width = 900) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "species")
