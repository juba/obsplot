library(shiny)
#library(obsplot)
devtools::load_all()
library(palmerpenguins)

data(penguins)

ui <- fluidPage(
    titlePanel("obsplot basic Shiny app"),
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "x_var",
                label = "x variable",
                choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")
            ),
            selectInput(
                "y_var",
                label = "y variable",
                selected = "bill_depth_mm",
                choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")
            ),
            selectInput(
                "stroke_var",
                label = "stroke variable",
                choices = c("island", "species", "sex")
            )
        ),
        mainPanel(
           obsplotOutput("chart")
        )
    )
)

server <- function(input, output) {
    output$chart <- renderObsplot({
        obsplot(penguins, height = 400, width = 800) |>
            mark_dot(x = input$x_var, y = input$y_var, stroke = input$stroke_var) |>
            opts(grid = TRUE)
    })
}

shiny::runApp(shinyApp(ui = ui, server = server))
