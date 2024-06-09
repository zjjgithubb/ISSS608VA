pacman::p_load(shiny, tidyverse)

exam <- read_csv("data/Exam_data.csv")

#set as fluidPage - auto change layout according to the dimensions of the output 
#sidebar layout -> for inputs
#mainpanel -> mainly for the output and graph 
#make sure the input and output variables are synchronised! 

ui <- fluidPage(
  titlePanel("Pupils Examination Result Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable",
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
      sliderInput(inputId = "bins",
                  label = "Number of Bins",
                  min = 5,
                  max = 20, 
                  value = 10)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output){
  output$distPlot <- renderPlot({
    ggplot(data = exam, 
           aes_string(x = input$variable)) +
      geom_histogram(bins = input$bins,
                     color = "black",
                     fill = "light blue")
  })
}

shinyApp(ui = ui, server = server)
