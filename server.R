# Load Libraries
library(shiny)
library(datasets)
library(ggplot2)
library(corrplot)
require(stats)
require(graphics)



# We load the data
data(mtcars)
mpgData <- mtcars[,c(1:4,6,9 )]
# We tweak the "am" field to have nicer factor labels.
mpgData$am <- factor(mpgData$am, labels = c("0 - Automatic", "1 - Manual"))
# Building a regression model
fit <- lm (mpg ~ cyl + am + wt + disp, data=mpgData)
#prediction <- predict(fit, data=newdata)
prob <- function( am, wt, disp, cyl, hp) {38.20 - 1.56 * am -  3.3 * wt + 0.012 * disp - 1.11 * cyl - 0.03 * hp}
# Define server logic required to summarize and view the selected data
shinyServer(
        function(input, output) {
                
                # Create reactive
                newData <- reactive({
                        #as.data.frame(mpgData)
                        mpgData[33,1] <- 38.20 - 1.56 * as.numeric(input$id4) -  3.3 * as.numeric(input$id1)
                        + 0.012 * as.numeric(input$id2) - 1.11 * as.numeric(input$id3) - 0.03 * as.numeric(input$id5)
                        mpgData[33,2] <- as.numeric(input$id3)
                        mpgData[33,3] <- as.numeric(input$id2)
                        mpgData[33,4] <- as.numeric(input$id5)
                        mpgData[33,5] <- as.numeric(input$id1)
                        mpgData[33,6] <- as.numeric(input$id4)
                        mpgData[33,7] <- 1
                        as.data.frame(mpgData)
                })
             
                # Create Output and id Variables
                output$wt <- renderPrint({input$id1})
                output$disp <- renderPrint({input$id2})
                output$cyl <- renderPrint({input$id3})
                output$am <- renderPrint({input$id4})
                output$hp <- renderPrint({input$id5})
                # Create Prediction
                output$prediction <- renderPrint({prob(input$id4, input$id1, input$id2, input$id3, input$id5)})
                # Create a correlation, EDA and predictive plot
                output$newHist <- renderPlot({
                M <- cor(mtcars[,c(1:4,6,9 )])
                corrplot.mixed(M)
                        })
                output$newHist2 <- renderPlot({
                        pairs(mpgData, panel = panel.smooth, main = "Mtcars data", col = 3 + (mpgData$mpg > 22))
                        })
                output$newHist3 <- renderPlot({
                        #plot(newData[1:32, ]$mpg, col="blue", pch=16)
                        #plot(newData[33, ]$mpg, col="red", pch=16)
                        ggplot(newData(), 
                               aes(x = wt, y = mpg, colour = factor(V7) )) + 
                                geom_point() + xlab("Weight") +
                                ylab("Miles/(US) gallon")+ scale_color_discrete(
                                        name="",
                                        breaks=c("0", "1"),
                                        labels=c("Cars from data", "Your car")
                                )
                })
                # Generate a summary of the dataset
                output$summary <- renderPrint({
                        summary(mpgData[,2:5])
                })
                
                # Show the first "n" observations
                output$view <- renderTable({
                        head(mpgData, 10)
                })
        }
)
