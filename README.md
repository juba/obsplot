<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-red.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![R build status](https://github.com/juba/obsplot/workflows/R-CMD-check/badge.svg)](https://github.com/juba/obsplot/actions)
<!-- badges: end -->

# Obsplot

`obsplot` is an experimental attempt at using [Observable Plot](https://observablehq.com/@observablehq/plot) directly from R.

Please note that the package is in an early stage. Its API is subject to breaking changes, there are bugs, and maybe bad design choices. You have been warned, but if you still want to try it issues and feedback are very welcome !

Also note that for the moment `obsplot` will not work in the RStudio viewer, due to its usage of an outdated web rendering engine. You can either open the visualisation in a browser, or use [R in VSCode](https://github.com/REditorSupport/vscode-R).

## Examples 

Here a small example of a simple scatterplot from the `penguins` dataset of the `palmerpenguins` package :

```r
library(palmerpenguins)
data(penguins)

obsplot(penguins) |>
    mark_dot(x = "bill_length_mm", y = "bill_depth_mm", stroke = "sex") |>
    opts(grid = TRUE)
```

![Simple scatterplot](man/figures/readme_scatter.png)

And here is a much more complex example taken from Observable Plot documentation :

```r
data(stateage)

stateage <- stateage |>
    tidyr::pivot_longer(!name, names_to = "age", values_to = "population")

xy <- transform_normalizeX(basis = "sum", z = "name", x = "population", y = "name")

obsplot(stateage, height = 660) |>
    mark_ruleX(x = 0) |>
    mark_ruleY(transform_groupY(list(x1 = "min", x2 = "max"), xy)) |>
    mark_dot(xy, fill = "age", title = "age") |>
    mark_text(transform_selectMinX(xy), textAnchor = "end", dx = -6, text = "name") |>
    scale_x(axis = "top",   label =  "Percent (%) →", transform = JS("d => d * 100")) |>
    scale_y(axis = NULL) |>
    scale_color(scheme = "spectral", domain = unique(stateage$age)) |>
    opts(grid = TRUE)
```

![stateage example](man/figures/readme_stateage.png)

You will find many more examples in the two gallery vignettes :

- [marks gallery](https://juba.github.io/obsplot/articles/gallery_marks.html)
- [facets and transforms gallery](https://juba.github.io/obsplot/articles/gallery_transforms.html)

To get satarted, take a look at the [introduction vignette](https://juba.github.io/obsplot/articles/introduction.html).

## Installation

From Github :

```r
remotes::install_github("juba/obsplot")
```

## Credits

- Obviously, the [Observable Plot](https://observablehq.com/@observablehq/plot) library developed by [Mike Bostock](https://observablehq.com/@mbostock) and [Philippe Rivière](https://observablehq.com/@fil/) at [Observable](https://observablehq.com/).
- The [htmlwidgets](https://www.htmlwidgets.org/) package, which does all the heavy work to bridge R and JavaScript.
- [John Coene](https://twitter.com/jdatap) for the [packer](https://github.com/JohnCoene/packer) package, the [JavaScript for R book](https://book.javascript-for-r.com/) and the [g2r](https://github.com/devOpifex/g2r/) package which is a great source of inspiration.
