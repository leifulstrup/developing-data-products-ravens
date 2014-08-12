require(shiny)

# load package to read excel files
suppressWarnings(install.packages("xlsx", repos='http://cran.us.r-project.org')) # need to set CRAN source or it ejects error
suppressWarnings(require(xlsx))
#assumes the Ravens 2008 to Present Score Excel file is present in diretory
# add check on whether that is true

RavensSummary <- read.xlsx("Ravens-since-2008.xlsx",1) # sheet 1 has the summary info
RavensScores <- read.xlsx("Ravens-since-2008.xlsx",2) # sheet 2 has the scores for all games since 2008 season (since Joe Flacco showed up)

# add column of binary 1 for Wins
RavensScores$Wins <- ifelse(RavensScores$WinOrLoss == "W", 1, 0)

# develop a generalized linear model for predicting Win based on Ravens Score
logRavens <- glm(RavensScores$WinOrLoss ~ RavensScores$Ravens, family="binomial") # use Regression class model with my new 5 year history info

# function to predict Ravens probability of a win based on beta0 and beta1 coefficients - generalized so I can plug in confidence intervals
probWin <- function(score, beta0, beta1) {1/(1+exp(-1*(beta0+ score* beta1)))}

beta0 <- coef(logRavens)[1] # get intercept
beta1 <- coef(logRavens)[2] # get slope

RavensConfInt <- confint(logRavens)

beta0Lower <- RavensConfInt[1]
beta0Upper <- RavensConfInt[3]
beta1Lower <- RavensConfInt[2]
beta1Upper <- RavensConfInt[4]

inputScores <- seq(0,60, by = 1)

probRavensMiddle <- probWin(inputScores, beta0, beta1)
probRavensUpper <- probWin(inputScores, beta0Upper, beta1Upper)
probRavensLower <- probWin(inputScores, beta0Lower, beta1Lower)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a prediction. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$ProbabilityPlot <- renderPlot({
    
    RavensScore <- input$RavensScore
    computeProbability <- probWin(RavensScore, beta0, beta1)
    
    # draw the histogram with the specified number of bins
    plot(inputScores, probRavensMiddle, ylab="Probability of Ravens Win", xlab="Ravens Score", main="GLM using Ravens 2008-2013 Seasons\n with Upper and Lower 95% Confidence Intervals")
    lines(probRavensUpper, col="blue")
    lines(probRavensLower, col="red")
    abline(v=RavensScore, h=computeProbability,col=3,lty=6)
    
    output$computeProbability <- renderText(paste('Probability of Ravens Win: ', round(computeProbability*100,1), " %"))
    
    upperBound <- probWin(RavensScore, beta0Upper, beta1Upper)
    lowerBound <- probWin(RavensScore, beta0Lower, beta1Lower)
    upperPercent <- round(upperBound*100,1)
    lowerPercent <- round(lowerBound*100,1)
    bounds <- paste("UpperBound:", upperPercent, " %", " LowerBound:", lowerPercent, " %")
    output$confidenceBounds <- renderText(bounds)
    
    })
})