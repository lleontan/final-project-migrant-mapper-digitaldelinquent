library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

source("./scripts/BuildMap_shiwen.R")
source("./scripts/Updated Data.R")
source("./scripts/drawGraph.r")

birthplaces<-data
regions<-read.csv("./data/USA_regions_birthplace.csv")

shinyServer(function(input, output, session) {
  birthplaces <- data
  # for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
  # for now renders a plotly, change to whatever whenever the map is done
  birthplaces<-read.csv("./data/USA_by_birthplace.csv")
  
  output$map <- renderPlotly({
    return(BuildMap_shiwen(birthplaces,input$mapYear))
  })
  output$total.pie.chart<-renderPlotly({
    largestContributorsGraph(input$pie.country.count)
  })
  output$countrySumChart<-renderPlotly({
    getCountrySumGraph(regions, input$countrySumSelectedCountry)
  })
})