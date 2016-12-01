library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
source("drawMap.r")

birthplaces<-read.csv("./data/USA_by_birthplace.csv")
regions<-read.csv("./data/USA_regions_birthplace.csv")

shinyServer(function(input, output, session) {
  # for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
  #for now renders a plotly, change to whatever whenever the map is done
  output$map <- renderPlotly({
<<<<<<< f6101b5e49412a63e0d3da80657541e3dcd7ab4c
    makeMap(input$year)
=======
    return(makeMap())
>>>>>>> Finish general appearance of shiny app
  })
})