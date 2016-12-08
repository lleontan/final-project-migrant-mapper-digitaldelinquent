library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

source("./scripts/BuildMap_shiwen.R")
source("./scripts/Updated Data.R")
source("./scripts/drawGraph.r")
source("./scripts/SearchByCountry.R")

regions<-read.csv("./data/USA_regions_birthplace.csv")
birthplaces<-read.csv("./data/USA_by_birthplace.csv")

shinyServer(function(input, output, session) {
  # for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
  # for now renders a plotly, change to whatever whenever the map is done

  
  output$map <- renderPlotly({
    return(BuildMap_shiwen(birthplaces,input$mapYear))
  })
  
  output$total.pie.chart<-renderPlotly({
    largestContributorsGraph(input$pie.country.count, birthplaces)
  })
  
  output$countrySumChart<-renderPlotly({
    getCountrySumGraph(regions, input$countrySumSelectedCountry)
  })
  
  output$searchCountry<-renderPlotly({
    SearchByCountry(birthplaces,input$text)
  })
  
  output$countryInfo <- renderText({
    getCountryInformation(input$text)
  })
})