library(dplyr)
library(plotly)
library(shiny)
source("./scripts/drawGraph.r")
source("./scripts/Updated Data.R")

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
                 p("Immigration has become a hot button issue in the United States.
                   Using data from the United Nations Population Division of the Department of Economic and 
                   Social Affairs (DESA) we've attempted to chart global migration patterns
                   to show the realistic scale and trends of worldwide immigration. We hope that
                   by showing the realities of immigration we may challenge preconceived
                   notions about the issue."), 
                 br(),
                 plotlyOutput("map"),
                 br(),
                 p("The map above is essentially a heat map for immigration.  Each country is filled in a different shade to 
                   signify the number of immigrants from that country. The countries colored in dark have a large number of 
                   immigrants coming to the United States, while lighter colors mean fewer immigrants. Hovering over a country 
                   will display the number of immigrants from that country."),
                 br(),
                 br(),
                 br()
               )
             )
    ),
    tabPanel("Details",
             sidebarLayout(
               position = "right",
               sidebarPanel(
                 inputId="mapYear", 
                 # add Widget
                 sliderInput(inputId="pie.country.count",
                             "Countries", 
                             min=1, 
                             max=20,
                             value = 15,
                             animate=TRUE
                 ),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               hr(),
                 selectInput("text",
                           label = "Country",
                           choices = birthplaces$OdName
                 )
               ),
               mainPanel(
                 plotlyOutput("total.pie.chart"),
                 br(),
                 p("This pie chart displays the portion of immigration for each country.  Using the Countries tool,
                   you can move the slider to decide the number of countries to display the immigration statistics. 
                   Leaving the slider at one will display Mexico's immigration statistics and compare it to all the other
                   countries combined. Each time the slider is moved, the country with the next highest amount of 
                   immigration will be displayed on the pie chart."),
                 hr(),
                 h3("Immigrant of specific country"),
                 p(textOutput("countryInfo")),
                 br(),
                 plotlyOutput("searchCountry"),
                 hr()
               )
             )
    ),
    
    tabPanel("Plot",
               position = "right",
               sidebarPanel(
                 inputId="sumChartPanel", 
                 selectInput(
                   inputId = "countrySumSelectedCountry",
                   label = h3("Country"),
                   choices = c("None", as.vector(getCountrySum(birthplaces)$OdName[2:9])),
                   selected = 1
                 )
                )
              ,
             mainPanel(width = 11,
               plotlyOutput("countrySumChart",height = 550),
               br(),
               p("This bar chart displays the total yearly immigration into the United States.
                 Each color is for a different region of the world (for example, purple = Central America).
                 When hovering over a bar, the statistics for that region will be displayed for that year.
                 Most regions have a steady flow of immigration, but Central America has major changes from year to year."),
             br(),
             br(),
             br()
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


