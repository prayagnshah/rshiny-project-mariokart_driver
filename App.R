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
      
      ##Adding the date range so that user can choose from which period businesses were closed
      dateRangeInput('dateRange',
                     label = 'Date range input: yyyy-mm-dd',
                     start = Sys.Date() - 2, end = Sys.Date() + 2
      ),
      
    ),
    mainPanel(
      tabsetPanel(
        
        #Panel1, output will be shown in Table format
        tabPanel(
          "Table",
          dataTableOutput("table")
        ),
        
        #Panel 2, output will be in map format
        tabPanel(
          "Map", 
          leafletOutput("map", width = "100%")
        )
      )
    )
  )
)


server <- function(input, output, session) {
  
  output$dateRangeText  <- renderText({
    paste("input$dateRange is", 
          paste(as.character(input$dateRange), collapse = " to ")
    )
  })
  
}



##Call to shiny
shinyApp(ui, server)