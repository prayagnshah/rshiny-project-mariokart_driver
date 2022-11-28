library(datasets)


location <- read.csv("data/loading-data.csv")



mario <- read.csv("bodies.csv")
head(mario)












library(shiny)
library(sf)
library(leaflet)


location <- read.csv("data/loading-data.csv")
head(location)
tail(location)
location[ , c("VALUE")]   

ui <- fluidPage(
  
  ##Title of the application 
  titlePanel("Number of businesses closed during the Covid"),
  
  
  sidebarLayout(
    
    #Menu
    sidebarPanel(
      
      ##sorting the filtered data using the location
      selectInput("geolocation", label = "Province", choices = sort(unique(location$GEO))),
      
      # ##sorting the data according to the Month
      # selectizeInput("REF_DATE", label = "Month", choices = sort(unique(location$REF_DATE, multiple = TRUE)))
      
    ),
    mainPanel(
      tableOutput("LocationData")
    )
  )
)


server <- function(input, output, session) {
  
  
  
  # ##Table output and rendering to print the filtered values 
  #   output$table <- reactive({
  #     
  #   ##We are subsetting the values based on location and giving it back to loading_data_filter
  #   # loading_data_filter <- subset(location, location$VALUE == input$geolocation)
  #   dplyr::filter(
  #     location,
  #     geolocation %in% location$VALUE
  #   )
  # })
  
  #Table output
  output$LocationData <- renderDataTable({
    loading_data_filter <- subset(location, location$REF_DATE == input$geolocation)
    
    
  })
  
}



##Call to shiny
shinyApp(ui, server)