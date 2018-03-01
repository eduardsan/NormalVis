#
# This is the server logic of a Shiny web application.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic
shinyServer(function(input, output) {
  
  # draw plot
  output$distPlot <- renderPlot({
    # generate random numbers following a normal distribution with the given paramenters
    normdata <-
      as.data.frame(x = rnorm(input$num, mean = input$mean, sd = input$sd))
    names(normdata) <- c("x")

    # draw reference density plot and density plot with random numbers
    p <- ggplot(data = normdata, aes(x)) + 
      stat_function(fun = dnorm, n = 1000, args = list(mean = input$mean, sd = input$sd), 
                    aes(colour = "normal")) +
      scale_y_continuous(breaks = NULL) + 
      geom_density(aes(color = "random"))

    # determine where to draw the quantile line
    pos <-
      ifelse(
        input$radio == 1,
        input$param,
        qnorm(input$param, mean = input$mean, sd = input$sd, lower.tail = input$lower.tail)
      )
    
    # add mean and quantile lines to plot
    p <- p + geom_vline(aes(xintercept = input$mean, color = "mean")) +
      geom_vline(aes(xintercept = pos, color = "quantile")) +
      scale_color_manual(
        name = "", 
        values = c(normal = "dimgray", random = "blue", mean = "forestgreen", quantile = "firebrick"))
    p
  })
  # compute quantile value
  output$svrq <- renderText({
    ifelse(
      input$radio == 1,
      input$param,
      qnorm(
        input$param,
        mean = input$mean,
        sd = input$sd,
        lower.tail = input$lower.tail
      )
    )
  })
  # compute probability value
  output$svrp <- renderText({
    ifelse(
      input$radio == 1,
      pnorm(
        input$param,
        mean = input$mean,
        sd = input$sd,
        lower.tail = input$lower.tail
      ),
      input$param
    )
  })
})
