#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # draw the density plot with the specified parameters
    normdata <-
      as.data.frame(x = rnorm(input$num, mean = input$mean, sd = input$sd))
    names(normdata) <- c("values")
    pos <-
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
    ggplot(data = normdata, aes(values)) +
      geom_density(aes(color = "density")) +
      geom_vline(aes(xintercept = input$mean, color = "mean")) +
      geom_vline(aes(xintercept = pos, color = "quantile")) +
      scale_color_manual(name = "", values = c(density = "blue", mean = "forestgreen", quantile = "firebrick"))
  })
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
