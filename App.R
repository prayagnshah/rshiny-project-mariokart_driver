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
      selectInput("GEO", label = "Province", choices = sort(unique(location$GEO))),
      
      # ##sorting the data according to the Month
      # selectizeInput("REF_DATE", label = "Month", choices = sort(unique(location$REF_DATE, multiple = TRUE)))

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

''
server <- function(input, output, session) {
  
 
  
  ##Table output and rendering to print the filtered values 
    output$table <- renderDataTable({
      
    ##We are subsetting the values based on location and giving it back to loading_data_filter
    loading_data_filter <- subset(location, location$Industry == input$GEO)
    
  })
  
}



##Call to shiny
shinyApp(ui, server)