library(dplyr)


# year data within birthplaces
yearIndexes<-grep("X", colnames(birthplaces))
yearTable<-birthplaces[c(1,3,yearIndexes)]
yearNames<-gsub("X",x=colnames(birthplaces[yearIndexes]), replacement="")
# for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
shinyUI(
  fluidPage(
    titlePanel("MigrantMapper by Digital Deliquents"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("year", "Year", 
                    min=yearNames[1], max=yearNames[length(yearNames)], value=yearNames[1]
                    )
      ),
      mainPanel(plotlyOutput("map"))
    )
  )
)