# Bubble chart
SearchByCountry <- function(d,country){
  yearIndexes<-grep("X", colnames(d))
  yearNames<-as.numeric(gsub("X",x=colnames(d[yearIndexes]), replacement=""))
  
  # Displays years without commas (ex. 1,980 to 1980)
  d <- d %>%
       filter(OdName == country)
  x <- d[yearIndexes]
  population <- as.numeric(paste(x)) 
  yearNames <- as.numeric(yearNames)
  m <- data.frame(yearNames,population) 
  m <- na.exclude(m)
  # Sets up hover and color bar and sets x and y axis in the bubble chart
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
               line = list(color = "rgba(219,138,19,0.5)",
                           shape = "spline",
                           smothing = 1.3
                           ),
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
    # sets up the layout of the bubble chart   
    layout(title = paste0("Number of immigrants from ", country, " each year"),
              xaxis = list(showgrid = FALSE,
                           ticklen = 3,
                           title = "year"),
              yaxis = list(showgrid = FALSE,
                           ticklen = 3,
                           title = "amount")
              )
               
  return(p)
}