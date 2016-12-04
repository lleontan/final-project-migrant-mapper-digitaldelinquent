library(dplyr)
library(plotly)
library(shiny)

# year data within birthplaces
yearIndexes<-grep("X", colnames(birthplaces))
yearTable<-birthplaces[c(1,3,yearIndexes)]
yearNames<-as.numeric(gsub("X",x=colnames(birthplaces[yearIndexes]), replacement=""))


# for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
shinyUI(
  navbarPage(
    "MigrantMapper by Digital Deliquents",
    inverse = TRUE,
    tabPanel('Overview',
             includeCSS('./data/style.css'),
             sidebarLayout(
               position = "right",
               sliderInput(inputId="mapYear",
                           "Year", 
                           min=yearNames[1], 
                           max=yearNames[length(yearNames)],
                           value = yearNames[1],
                           animate=TRUE
               ),
               mainPanel(
                 h3("General Information about Immigration in USA", 
                    align = "center"),
                 br(),
                 p("Immigration has has become a hot button issue in the United States.
                   Using data from the United Nations Population Division of the Department of Economic and 
                   Social Affairs (DESA) we've attempted to chart global migration patterns
                   to show the realistic scale and trends of worldwide immigration. We hope that
                   by showing the realities of immigration we may challenge preconceived
                   notions about the issue."), 
                 plotlyOutput("map")
                 )
               )
               ),
    tabPanel("Map",
             includeCSS('./data/style.css'),
             sidebarLayout(
               sidebarPanel(
                 position = "right",
                 inputId="mapYear", 
                 "Year", 
                 min=yearNames[1], 
                 max=yearNames[length(yearNames)],
                 value = yearNames[1]
                 # add Widget
               ),
               mainPanel(
               )
             )
    ),
    
    tabPanel("Plot",
             includeCSS('./data/style.css'),
               mainPanel(
                 plotlyOutput("countrySumChart")
               )
             )
    )
               )
               


