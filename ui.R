#
# This is the user-interface definition of a Shiny web application.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Normal Distribution Sandbox"),
  
  # Help text
  wellPanel(helpText("This Shiny website lets you experiment with a number of parameters related to ",
                     "a normal distribution. Use the controls on the left panel to specify the mean ",
                     "of the normal distribution, its standard deviation and the number of randomly ", 
                     "generated points that will be used to generate a density plot.",
                     "Additionally, you can provide a numeric input (quantile or probability) and set the
                     lower tail parameter. These values will be used to compute the corresponding quantile
                     and probability values that are displayed below the plot. Press the submit button
                     to send the specified parameters and update the plot."),
            helpText("The plot shows a \"perfect\" normal for reference (grey curve), a density plot",
                     "based on the randomly generated points (blue curve), the given mean (green line)",
                     "and the position of the given/computed quantile (red line).")),
  
  # Sidebar with input controls
  sidebarLayout(
    sidebarPanel(
       sliderInput("mean",
                   "Mean of the normal distribution:",
                   min = -50,
                   max = 50,
                   value = 0),
       sliderInput("sd",
                   "Standard deviation:",
                   min = 1,
                   max = 20,
                   value = 1),
       numericInput("num", label = "Number of normally distributed random points:", value = 100),
       radioButtons("radio", label = "Value type:",
                    choices = list("Quantile" = 1, "Probability" = 2), 
                    selected = 2),
       numericInput("param", label = "Quantile/probability value:", value = 0.95),
       checkboxInput("lower.tail", label = "Lower tail", value = TRUE),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       hr(),
       fluidRow(
         column(width = 3, h3("Quantile")), 
         column(width = 3, offset = 2, h3("Probability"))
       ),
       fluidRow(
         column(3, verbatimTextOutput("svrq")),
         column(width = 3, offset = 2, verbatimTextOutput("svrp")))
    )
  )
))
