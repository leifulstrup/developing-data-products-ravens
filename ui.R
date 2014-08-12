require(shiny)

# Define UI for inputing Ravens Score
shinyUI(fluidPage(
  
  # Application title
  titlePanel("GO Ravens!\n Predict Ravens Win Probability Given Current Score"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("RavensScore",
                  "Ravens Score",
                  min = 0,
                  max = 50,
                  value = 21)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("ProbabilityPlot"),
      textOutput('computeProbability'),
      p(""),
      textOutput('confidenceBounds'),
      p(""),
      p('Upper and Lower Confidence Level using +/- 2 SD -> @ 95%')
    )
  )
))