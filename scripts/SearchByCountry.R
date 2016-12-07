library(plotly)
library(dplyr)

SearchByCountry <- function(d,country){
  yearIndexes<-grep("X", colnames(d))
  yearNames<-as.numeric(gsub("X",x=colnames(d[yearIndexes]), replacement=""))
  
  d <- d %>%
       filter(OdName == country)
  x <- d[yearIndexes]
  population <- as.numeric(paste(x)) 
  yearNames <- as.numeric(yearNames)
  m <- data.frame(yearNames,population) 
  m <- na.exclude(m)
  
  p <- plot_ly(m,
               x = ~yearNames,
               y = ~population,
               text = ~paste("Immigrant amount:",population, '<br> Year:', yearNames),
               type = "scatter",
               mode = "markers",
               color = ~population,
               colors = "Accent",
               size = ~population,
               sizes = c(3,35),
               hoverinfo = "text",
               
               marker = list(
                             colorbar = list(
                                             title = "population",
                                             titlefont = list(size = 10),
                                             thickness = 12,
                                             tickfont = list(size = 10)
                             ),
                             sizemode = "diameter",
                             opacity = 0.7
               )) %>%
       layout(title = paste0("Number of imigrants of ", country, " in each year"),
              xaxis = list(showgrid = FALSE,
                           ticklen = 3,
                           title = "year"),
              yaxis = list(showgrid = FALSE,
                           ticklen = 3,
                           title = "amount")
              )
               
  return(p)
}