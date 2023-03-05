library(shiny)
library(ggplot2)
library(bslib)

ui <- fluidPage(
    theme = bs_theme(
        bg = "#002B36", fg = "#EEE8D5", primary = "#2AA198",
        base_font = font_google("Pacifico")
    ),
    tabsetPanel(
        type = "pills",
        tabPanel("ggplot", plotOutput("ggplot")),
        tabPanel("lattice", plotOutput("lattice")),
        tabPanel("base", plotOutput("base"))
    )
)

server <- function(input, output) {
    output$ggplot <- renderPlot({
        ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars), color = factor(cyl))) +
            geom_point() +
            ggrepel::geom_text_repel()
    })
    output$lattice <- renderPlot({
        lattice::show.settings()
    })
    output$base <- renderPlot({
        image(volcano, col = thematic_get_option("sequential"))
    })
}

thematic_shiny()
shinyApp(ui, server)
