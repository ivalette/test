library(shiny)
shinyUI(fluidPage(
        titlePanel("What Is The Fuel Performance Of Your Car?"),
        sidebarLayout(
                sidebarPanel(sliderInput('id1', 'Car Weight',value = 3.5, min = 1.5, max = 5.4, step = 0.5),
                             sliderInput('id2', 'Engine Size',value = 275, min = 71, max = 472, step = 10,),
                             numericInput('id3', "Number of Cylinders", 4, min = 4, max = 8, step = 2),
                             numericInput('id4', "Transmission Type", 0, min = 0, max = 1, step = 1),
                             sliderInput('id5', 'Horse Power',value = 202, min = 52, max = 335, step = 10),
                             submitButton('Submit')
                             
                ),
                mainPanel(
                        tabsetPanel(type = "tabs",
                        tabPanel("Summary",  
                                img(src = "Cars.png", height = 215, width = 477),
                                h3("Instructions"),
                                p("Use the inputs on the left-hand side of this application to calculate the fuel economy performance of 
                                  				your car measured in Miles per gallon (MPG). "),
                                br(),  
                                p("You can then see a summary of the specifications you selected under the Car Specification tab, 
                                          	and see how well your car is performing under the Fuel Performance tab. The data and EDA tabs will give you a feeling of what data foundation looks like."),
                                h3 ("Calculating the fuel performance of your car"),
                                p("The mtcars dataset in R was extracted from the 1974 Motor Trend US magazine, and comprises fuel 
                                          	consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models). 
                                			This application fits a linear model for Miles Per Gallon (mpg), using car specifications from the Motor Trend Car Road Tests dataset.
                                			The mpg model is built as follows:"),
                                code("fit <- lm (mpg ~ am +  wt + disp + cyl + hp, data=mtcars)"),
                                br(),
                                p("Key factors contributing to the mpg measurements are: The transmission type (am) where 0=Automatic and 1=Manual, car weight (wt), and engine size (disp), 
                                  number of cylinders (cyl) and gross horsepower (hp). ")
                                    ),
                        
                        tabPanel("Data",
                                 h3('Data Summary'),
                                 h4('Statistical Summary'),
                                 verbatimTextOutput("summary"),
                                 h4('The first 10 lines of the dataset'),
                                 tableOutput("view")
                        ),
                        
                        tabPanel("EDA",
                                 h3('Taking a quick look at the data'),
                                 h4('Exploratory Data Analysis'),
                                 plotOutput('newHist2'),
                                 h4('Correlation Plot'),
                                 plotOutput('newHist')
                                
                        ),
                        
                        tabPanel("Car Specifications",
                                h3('Your Selection'),
                                h4('You entered the following car weight (in lb/1000):'),
                                verbatimTextOutput("wt"),
                                h4('You entered the following engine size:'),
                                verbatimTextOutput("disp"),
                                h4('You entered the following number of cylinders:'),
                                verbatimTextOutput("cyl"),
                                h4('You entered the following type of transmission:'),
                                verbatimTextOutput("am"),
                                h4('You entered the following gross horsepower:'),
                                verbatimTextOutput("hp")
                                ),
                        
                        tabPanel("Fuel Performance",
                                h3('Your Fuel Performance'),
                                h4('Your specifications resulted in a fuel economy performance measured 
                                   in Miles per gallon (MPG) of: '),
                                verbatimTextOutput("prediction"), 
                                h4('Your Fuel Performance'),
                                plotOutput('newHist3')
                                )
                        
                      
                        
                        
                        ))    
        )
))