# Returns a plotly or ggplot2 map.
# Takes a country and year as input.
# Returns a map with an arrow pointing towards the united states size or color scaled for magnitude.
# Possible extras when feature complete could include, a indication of emmigration vs immigration(arrow direction),
#   Region indication, arrow style, uptrend or downtrending level.
<<<<<<< f6101b5e49412a63e0d3da80657541e3dcd7ab4c

library(dplyr)
=======
library(plotly)
library(ggplot2)

>>>>>>> Finish general appearance of shiny app
#duplicate code for testing, put it in another file somewhere or whatever.
yearIndexes<-grep("X", colnames(birthplaces))
yearTable<-birthplaces[c(1,3,yearIndexes)]
yearNames<-as.numeric(gsub("X",x=colnames(birthplaces[yearIndexes]), replacement=""))

#addCountryCodes(df){
 # return( df %>% mutate())
#}

makeMap<- function(year){
  # give map some sort of an input id for hovering, it should be equal to "country" and should be the country name.
  # Draw a line to america from whatever country is hovered over.
  # remove country input if unneccessary
<<<<<<< f6101b5e49412a63e0d3da80657541e3dcd7ab4c
  map<-birthplaces %>% plot_geo() %>% add_trace(text = ~OdName,color=~paste0("X",year))
  return(map)
=======
  # birthplaces %>% plot_geo() %>% add_trace(text = ~OdName,color=~paste0("X",year)) %>% return()
  set.seed(100)
  d <- diamonds[sample(nrow(diamonds), 1000), ]
  plot_ly(d, x = ~carat, y = ~price, color = ~carat,
          size = ~carat, text = ~paste("Clarity: ", clarity)) %>% return()
  
>>>>>>> Finish general appearance of shiny app
}