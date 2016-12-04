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
             sidebarLayout(
               position = "right",
               sidebarPanel(
                 sliderInput(inputId="mapYear",
                             "Year", 
                             min=yearNames[1], 
                             max=yearNames[length(yearNames)],
                             value = yearNames[1],
                             animate=TRUE
                 )
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
             sidebarLayout(
               position = "right",
               sidebarPanel(
                 inputId="mapYear", 
                 "Year", 
                 min=yearNames[1], 
                 max=yearNames[length(yearNames)],
                 value = yearNames[1],
                 # add Widget
                 sliderInput(inputId="pie.country.count",
                             "Countries", 
                             min=1, 
                             max=30,
                             value = 1,
                             animate=TRUE
                 )
               ),
               mainPanel(
                 plotlyOutput("total.pie.chart")
               )
             )
    ),
    
    tabPanel("Plot",
             mainPanel(
               plotlyOutput("countrySumChart")
             )
    ),
    
    tabPanel("About",
             mainPanel(
               h1("Project Description"),
               hr(),
               h3("Why does immigration matters?"),
               br(),
               p("The data throughout this website comes from", tags$a(href="http://www.un.org/en/development/desa/population/migration/data/empirical2/migrationflows.shtml", "UN Immigration Data"),
                 ". Migration statistics are important for the design of sensible migration policies, as immigrants can exert huge influence on social stability and economic development of United State.
                   By comparing the amount of immigrants flowing into US and economic gain of USA, it sheds light on the issue that whether migration has positive or negative impact to this country."),
               hr(),
               h3("Developers")
             ),
             
             fluidRow(
               img(src="http://nebula.wsimg.com/28e334a7d5626b9fe824f3b720ebf58f?AccessKeyId=D2AC8955135E87ED9D4F&disposition=0&alloworigin=1", width = "250px")
             )
    )
  )
)



