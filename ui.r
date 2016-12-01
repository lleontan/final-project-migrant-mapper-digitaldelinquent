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
    includeCSS('style.css'),
    sidebarLayout(
                  position = "right",
                  sidebarPanel(
                    # add Widget
                  ),
                  mainPanel(
                    h3("General Information about Immigration in USA", align = "center"),
                    br(),
                    p("These days, immigration has grown into a controversial issue among United State. 
                      In order to better understand this situation, we’re using America immigration data 
                      from the During United Nations Population Division of the Department of Economic and 
                      Social Affairs (DESA) to chart migration changes overtime to inform the general public 
                      about the realistic scale and trends of worldwide immigration in order to challenge 
                      preconceived notions about the issue. This data is of huge significance to many people, 
                      especially for those sociologists who are interested in the influence of immigrant to 
                      society. By comparing the growth of the population of immigrant with economic gain and 
                      crime rate, sociologists are provided with useful tool to draw a big picture about how 
                      immigrant has influenced the development of a country, which can help government to make 
                      better immigrant policy in the future."), 
                    plotlyOutput("map")
                  )
                )
       ),
       tabPanel("Map",
                includeCSS('style.css'),
                sidebarLayout(
                  position = "right",
                  sidebarPanel(
                    # add Widget
                  ),
                  mainPanel(
                  )
                )
       ),
       
       tabPanel("Plot",
                includeCSS('style.css'),
                sidebarLayout(
                  position = "right",
                  sidebarPanel(
                    # ADD Widget
                  ),
                  mainPanel(
                    plotlyOutput("countrySumChart")
                  )
                )
                
    )
  )
)


