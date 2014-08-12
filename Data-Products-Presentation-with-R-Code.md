Predicting Win Probability - Ravens 2014 
========================================================
author: Leif Ulstrup
date: August 12, 2014
title: JHU Developing Data Products Class Project


Premise
========================================================

The probabilty of the [Baltimore Ravens](http://www.baltimoreravens.com) (under quarterback [Joe Flacco](http://en.wikipedia.org/wiki/Joe_Flacco)) winning a game in 2014 can be predicted using 2008-2013 Win/Loss data to create a generalized linear model relating wins to Ravens points scored (predictor).

- Joe Flacco began as Ravens quarterback at the start of the 2008 Season; same quarterback for 96 games
- Strong offense performance reduces the dependence on defense and should be a good predictor of win probability
- It is fun for fans to assess win probability in the middle of a game

A [Shiny web application](http:http://lulstrup.shinyapps.io/GoRavens-JHU-Developing-Data-Products/) was created to enable Ravens fans to predict win probability by inputing the current score.

Predicting Ravens Win Prob vs Ravens Score
========================================================
Built a generalized linear model (GLM) using all Ravens regular season game wins/losses and score data (n=96) from 2008 until 2013.  Data source: NFL.com and wikipedia.com.


<img src="Data-Products-Presentation-with-R-Code-figure/unnamed-chunk-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

|                    | Estimate| Std. Error| z value| Pr(>&#124;z&#124;)|
|:-------------------|--------:|----------:|-------:|------------------:|
|(Intercept)         |    -3.26|       0.83|   -3.91|               0.00|
|RavensScores$Ravens |     0.18|       0.04|    4.55|               0.00|

Link to Shiny Application
========================================================

A [Shiny application](http://shiny.rstudio.com) was created to host an interactive version of the model on the cloud based site - [shinyapps.io](https://www.shinyapps.io)

[Click Here to Link to Shiny App for Interactive Version](http://lulstrup.shinyapps.io/GoRavens-JHU-Developing-Data-Products/)

The source code for the Shiny application and this presentation along with the Ravens 2008-2013 Win/Loss and Scores data can be found here at this link [https://github.com/leifulstrup/developing-data-products-ravens](https://github.com/leifulstrup/developing-data-products-ravens)

Future Explorations
========================================================

Potential future predictive model explorations:

- Consideration of Home vs Away game as a factor
- Quarter of Play & Time Remaining
- Greater Weighting to Recent Games and Season
- Inclusion of factors such as Turnover Ratio
- Inclusion of Defense and Offense Performance Measures

GO [RAVENS!](http://baltimoreravems.com)
![RavensLogo](http://prod.static.ravens.clubs.nfl.com/assets/img/raven-logo.png)
