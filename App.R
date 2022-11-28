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
print(column_names)

ui <- fluidPage(
  
  ##Title of the application
  titlePanel("Welcome to MarioKart Drivers"),
  
  ##Trying to make more pleasing using the themes
  theme = bslib::bs_theme(bootswatch = "yeti", version = 5),
  
  sidebarLayout(
    
    #Menu panel 
    
    sidebarPanel(
      
      ##sorting the filtered data into alphabetical order 
      
      selectInput("variable_speed", label = "Choose any speed value", choices = column_names),
    ),
    
    ##Mainpanel for the outputs
    mainPanel (
      tabsetPanel(
      
        ##Panel 1
        tabPanel(
          "Map-Visualization",
          dataTableOutput("table")
        )
      )
    ) 
      
     
  )
  
)


##Server side 


server <- function(input, output, session) { 
  
  output$table <- renderDataTable({
    
    ##Sorting the value of Character and Class according to their index value using factor function
    ##Sorting both of them at the same time
    characters_only <- factor(
      mario$Character, levels = mario$Character[order(mario$Class)],
    
      
     
  
    )
    
    
 } )
}


##Call to shiny
shinyApp(ui, server) 
