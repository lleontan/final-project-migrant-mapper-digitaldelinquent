library(dplyr)
yearNames<-grep("X.", colnames(birthplaces) )
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
    ),
    hover = hoverOpts(
      id = "country"
    )
  )
)