library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
source("drawMap.r")

birthplaces<-read.csv("./data/USA_by_birthplace.csv",check.names=TRUE)
regions<-read.csv("./data/USA_regions_birthplace.csv",check.names=TRUE)

shinyServer(function(input, output, session) {
  # for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
  #for now renders a plotly, change to whatever whenever the map is done
  output$map <- renderPlotly({
    makeMap(input$year,input$country)
  })
})