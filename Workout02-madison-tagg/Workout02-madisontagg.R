# Madison Tagg
# Workout02, Stat 133 Spring 2019
# Shiny App: Interactive way of the saving/interest scenarios
# Inputs:
#   initial: The initial amount
#   contrib: how much is deposited at the end of each year
#   return: annual rate of return 
#   growth: growth rate
#   years: time in years
#   facet: facet option for the plots
#
# Outputs:
#   Plot: A timeline graph based on input 
#   Table: A table wiht the information that was used for plotting



library(ggplot2)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   title = "Interactive Saving Simulation",
   
   # Sidebar 
   hr(),
   
   fluidRow(
     #First Column: Initial and Contrib
     column(3, 
            sliderInput("initial", 
                        label = "Initial Amount:",
                        min = 1,
                        max = 100000,
                        value = 1000),
     br(),
     sliderInput("contrib",
                 label = "Annual Contribution:",
                 min = 0,
                 max = 50000,
                 value = 2000)),
     
     #Second Column: Return and Growth Rate
     column(4, 
            offset = 1,
            sliderInput("return",
                        label = "Return Rate (in %):",
                        min = 0,
                        max = 20,
                        value = 5),
            
            #Slider four: Growth Rate (in %)
            sliderInput("growth",
                        label = "Growth Rate (in %):",
                        min = 0,
                        max = 20,
                        value = 2)
            ),
     
     #Third Column: Years and Facet
     column(4, 
            sliderInput("years",
                        label = "Years:",
                        min = 0,
                        max = 50,
                        value = 10),
            
            #Slider six: Facet
            selectInput("facet",
                        label = "Facet?",
                        choices = c("Yes", "No"),
                        selected = "No")
            )
     ),
   

      # Show a plot of the generated distribution
      mainPanel(
        
        #Output: Header and Graph 
        h4("Timelines"),
        plotOutput("timelinePlot", width = "150%", height = "500px"),
        
        #Output: Header and summary of distribution
        h4("Balances"),
        verbatimTextOutput("summaryTable")
      )
   )

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$timelinePlot <- renderPlot({
     
     years <- input$years
     return <- input$return
     growth <- input$growth
     initial <- input$initial
     contrib <- input$contrib
     
     if (input$facet == 'No'){
       
       modalities <- setNames(data.frame(matrix(ncol = 4, nrow = (years+1))), c("year", "no_contrib", "fixed_contrib", "growing_contrib"))
       for(i in 0:years){
         modalities[i+1,1] <- i
         modalities[i+1,2] <- future_value(amount = initial, rate = (return/100), years = i)
         modalities[i+1,3] <- future_value(amount = initial, rate = (return/100), years = i) + annuity(contrib = contrib,rate = (return/100), years = i)
         modalities[i+1,4] <- future_value(amount = initial, rate = (return/100), years = i) + growing_annuity(contrib = contrib, rate = (return/100), growth = (growth/100), years = i)
       }
       
       #graphing NO facet
       plotty <- ggplot(modalities, aes(x = year)) +
         geom_line(aes(y = no_contrib, colour = "no_contrib")) +
         geom_line(aes(y = fixed_contrib, colour = "fixed_contrib")) +
         geom_line(aes(y = growing_contrib, colour = "growing_contrib")) +
         ggtitle("Three modes of investing") + xlab("year") + ylab("value") +
         labs(color='variable') +
         scale_color_manual(values = c("light green", "light blue", "red"))
       
       return(plotty)}
     
     if (input$facet == 'Yes'){
       
       modalities <- setNames(data.frame(matrix(ncol = 4, nrow = (years+1))), c("year", "no_contrib", "fixed_contrib", "growing_contrib"))
       for(i in 0:years){
         modalities[i+1,1] <- i
         modalities[i+1,2] <- future_value(amount = initial, rate = (return/100), years = i)
         modalities[i+1,3] <- future_value(amount = initial, rate = (return/100), years = i) + annuity(contrib = contrib,rate = (return/100), years = i)
         modalities[i+1,4] <- future_value(amount = initial, rate = (return/100), years = i) + growing_annuity(contrib = contrib, rate = (return/100), growth = (growth/100), years = i)
       }
       
       facet_table <- setNames(data.frame(matrix(ncol = 3, nrow = (years+1)*3)), c("year", "Contrib_Type", "Value"))
       facet_table[ ,2] <- c(rep("no_contrib", (years+1)), rep("fixed_contrib", (years+1)), rep("growing_contrib", (years+1)))
       facet_table[ ,1] <- c(rep(0:years, 3))
       facet_table[0:(years+1), 3] <- modalities[ , 2]
       facet_table[(years+2):(years*2+2), 3] <- modalities[ ,3]
       facet_table[(years*2+3):(years*3+3), 3] <- modalities[ ,4]
       facet_table$facet = factor(facet_table$Contrib_Type, levels = c("no_contrib", "fixed_contrib", "growing_contrib"))
       
       #graphing YES facet
       facet_plot <- ggplot(facet_table, aes(x = year)) +
         geom_area(aes(y = Value, fill = Contrib_Type), alpha = .5) +
         facet_wrap(.~facet) +
         geom_line(aes(y = Value, color = Contrib_Type)) +
         geom_point(aes(y = Value, color = Contrib_Type), size = .75) +
         scale_fill_manual(values = c("light green", "light blue", "red")) +
         scale_color_manual(values = c("light green", "light blue", "red"))
       
       return(facet_plot)}
   })
   
   output$summaryTable <- renderPrint({
     years <- input$years
     return <- input$return
     growth <- input$growth
     initial <- input$initial
     contrib <- input$contrib
     
     modalities <- setNames(data.frame(matrix(ncol = 4, nrow = (years+1))), c("year", "no_contrib", "fixed_contrib", "growing_contrib"))
     
     for(i in 0:years){
       modalities[i+1,1] <- i
       modalities[i+1,2] <- future_value(amount = initial, rate = (return/100), years = i)
       modalities[i+1,3] <- future_value(amount = initial, rate = (return/100), years = i) + annuity(contrib = contrib,rate = (return/100), years = i)
       modalities[i+1,4] <- future_value(amount = initial, rate = (return/100), years = i) + growing_annuity(contrib = contrib, rate = (return/100), growth = (growth/100), years = i)
     }
     modalities
   })
}


# Run the application 
shinyApp(ui = ui, server = server)

