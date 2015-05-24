# ==============================================================================
#        server.R : Coursera 09 Assignment - Developing Data Products
# ==============================================================================
# Author : FroggyZ
# Date   : May 24, 2015
# Purpose: DataScience Course 09 Project
# ==============================================================================

library(shiny)

shinyServer(
     function(input,output){
          
          ## -------------------
          ## Simulated Data step
          ## -------------------
          
          ## Generate n values from N(mean, sd)
          dta <- reactive({
               list(do.call("rnorm", 
                            list(n=input$n, mean=input$mu, sd=input$std)),
                    c("mean","sd")) 
          })

          ## ---------------------------------
          ## What to print in Tab Panel "Plot"
          ## ---------------------------------
          
          ## Plot Histogram of Data Generated
          output$plot <- renderPlot({
               
               # Plot Data Histogram
               hist(dta()[[1]], main="Histogram of Generated Data", 
                    xlab="X values", ylab="density", 
                    col="lemonchiffon2",cex.axis=1.2, cex.lab=1.2, prob=T)
               
               # Add vertical line for mean
               abline(v=mean(dta()[[1]]), col="darkgreen", lwd=4)
               
               # Add density curve
               if(input$density) {
                    # Plot observed density curve
                    # lines(density(dta()[[1]]), lwd=3, col="red")
                    # Plot theorical density curve
                    xfit <-seq(min(dta()[[1]]),max(dta()[[1]]),length=40) 
                    yfit <-dnorm(xfit,mean=mean(dta()[[1]]),sd=sd(dta()[[1]])) 
                    lines(xfit, yfit, col="blue", lwd=2)
                    }
               }) 
          
          ## ------------------------------------
          ## What to print in tab panel "Summary"
          ## ------------------------------------
          
          ## Print R Generic Data Summary
          output$textSummary <- renderPrint({
               cat("Generic summary from R:")
          })
          output$summary <- renderPrint({
               summary(dta()[[1]])
               })
          
          
          ## Print additional interesting information
          output$nbobs <- renderPrint({
               cat("For Selected Sample Size = ", input$n)
          })
          output$simMean <- renderPrint({
               cat("Corresponding Simulated Mean = ", mean(dta()[[1]]))
          })
          output$simStd <- renderPrint({
               cat("Corresponding Simulated Standard Deviation = ", sd(dta()[[1]]))
          })
          
          ##Just for fun, print other calculations that have nothing to do...
          output$forFun <- renderUI({
               z1 <- 2
               z2 <- 5
               str1 <- paste("And Now, Just For Fun, print something that has nothing to do with main project:")
               str2 <- paste("In server.R, using z1 = ", z1, " and z2 = ", z2)
               str3 <- paste("Compute (z1 + z2) = ", z1+z2)
               HTML(paste(str1, str2, str3, sep = '<br/>'))
               
          })
          
          ## -------------------------------------------
          ## What to print in tab panel "Generated Data"
          ## -------------------------------------------
          output$table <- renderTable({
               data.frame(x=dta()[[1]])
               })
          }
     )