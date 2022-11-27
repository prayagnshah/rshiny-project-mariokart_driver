library(shiny)
library(sf)
library(leaflet)


location <- read.csv("data/loading-data.csv")
head(location)
tail(location)


ui <- fluidPage(
  
  ##Title of the application 
  titlePanel("Number of businesses closed during the Covid"),
  
  
  sidebarLayout(
    
    #Menu
    sidebarPanel(
      
      ##sorting the filtered data using the location
      selectInput("Location", label = "Province", choices = sort(unique(location$GEO))),
      
    ),
    mainPanel(
      tabsetPanel(
        
        #Panel1
        tabPanel(
          "Table",
          dataTableOutput("table")
        )
      )
    )
  )
)


server <- function(input, output, session) {
  
}






##Call to shiny
shinyApp(ui, server)