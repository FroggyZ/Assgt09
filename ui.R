# ==============================================================================
#         ui.R : Coursera 09 Assignment - Developing Data Products
# ==============================================================================
# Author : FroggyZ
# Date   : May 24, 2015
# Purpose: DataScience Course 09 Project
# ==============================================================================

shinyUI(
     pageWithSidebar(
          
          headerPanel(h2("Generating and Plotting Normal Random Variables")),
          
          sidebarPanel(
               sliderInput("n","Sample size:",1,1000,500),
               numericInput("mu","Mean:",0),
               numericInput("std","Std:",1),
               checkboxInput("density","Show density curve",FALSE)
               ),
          
          mainPanel(
               tabsetPanel(
                    tabPanel("Plot",plotOutput("plot")),
                    tabPanel("Summary",
                             br(),
                             textOutput("textSummary"),
                             br(),
                             verbatimTextOutput("summary"),
                             br(),
                             textOutput("nbobs"),
                             textOutput("simMean"),
                             textOutput("simStd"),
                             br(),
                             htmlOutput("forFun")
                             ),
                    tabPanel("Generated Data",tableOutput("table"))
                    )
               )
          )
     )