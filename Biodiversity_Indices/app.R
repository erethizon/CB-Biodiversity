#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Biodiversity Index Explorer"),
######################################
tabsetPanel(
    #Species Richness
    tabPanel("Species Richness", fluid = TRUE,
        sidebarLayout(
            sidebarPanel(
                selectInput(
                    "NumberOfSpecies",
                    h3("How many species in your community?"),
                    choices = c(10,20,30,40,50,60, 70, 80, 90, 100),
                    selected = 100),
                 ),
            mainPanel(
                h5("Examine the output in the figure below"),
                plotOutput(outputId = "SpeciesRichness"))
                )
             )
        ),
    #Simpson's Index
    tabPanel("Simpson's Index", fluid = TRUE,
        sidebarLayout(
            sidebarPanel(
                selectInput("NumberOfSpecies",
                        h3("How many species in your community?"),
                        choices = c(10,20,30,40,50,60,70,80,90,100),
                        selected = 100),
                selectInput("Number of Trials",
                            h3("How many iterations would you like?"),
                            choices = c(10, 100, 1000),
                            selected = 100),
                 ),
            mainPanel(
            h5("This graph displays"),
            plotOutput(outputId = "foresthist"))
             )
    ),

    )
)


    ###################################################
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
