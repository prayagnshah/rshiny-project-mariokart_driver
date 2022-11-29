library(shiny)
library(ggplot2)


##Loading the data
mario <- read.csv("data/characters.csv")
head(mario)



characters <- mario$Character
var <- mario$Character[order(mario$Class)]
print(var)

##printing only coloumns and it will be used as the user input
column_names = colnames(mario)

##filtering the first two coloumns to get the properdata
filter_coloumns <- column_names[! column_names %in% c("Character", "Class")]
print(filter_coloumns)




ui <- fluidPage(
  
  ##Title of the application
  titlePanel("Welcome to MarioKart Drivers"),
  
  ##Trying to make more pleasing using the themes
  theme = bslib::bs_theme(bootswatch = "yeti", version = 5),
  
  sidebarLayout(
    
    #Menu panel 
    
    sidebarPanel(
      
      ##sorting the filtered data into alphabetical order 
      
      selectInput("variable_speed", label = "Choose any speed value", choices = filter_coloumns),
    ),
    
    ##Mainpanel for the outputs
    
    mainPanel (
      tabsetPanel(
      
        ##Panel 1
        tabPanel(
          "Map-Visualization",
          plotOutput("table")
        )
      )
    ) 
      
     
  )
  
)




##Server side 


server <- function(input, output, session) { 
  
  output$table <- renderPlot({
    
    
    ##Using ggplot to make the interactive graph and using geom_point to have the point shape structure 
    ggplot(data=mario, aes_string(x='Character', y=input$variable_speed, fill="Class", color = "Class")) +

      geom_point(size = 4) + 
      labs(x='Character', y = input$variable_speed) + coord_flip() +
      theme_minimal()
    
    
 })
}


##Call to shiny
shinyApp(ui, server) 
