library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
source("drawMap.r")
source("drawGraph.r")

birthplaces<-read.csv("./data/USA_by_birthplace.csv")
regions<-read.csv("./data/USA_regions_birthplace.csv")

shinyServer(function(input, output, session) {
  # for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
  # for now renders a plotly, change to whatever whenever the map is done
  birthplaces<-read.csv("./data/USA_by_birthplace.csv")
  
  output$map <- renderPlotly({
    return(makeMap(input$year))
  })
  output$countrySumChart<-renderPlotly({
    return(getCountrySumGraph(birthplaces,input$year))
  })
})