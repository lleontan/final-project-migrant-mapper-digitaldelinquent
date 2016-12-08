# Builds the world map
BuildMap_shiwen <- function(data,year){
  l <- list(color = toRGB("grey"), width = 0.5)
  year <- paste0("X",year)
  data <- mutate_(data, population = year)
  n <- as.character(data$population)
  n <- as.numeric(n)
  n <- is.na(n)

  # Sets details of the map
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )     
  data$hover <- with(data,paste(OdName,'<br>',"Population",population))
  # Creates data hover and color bar to provide a scale
  p <- data %>%
      plot_geo() %>%
    add_trace(
      z = ~population, 
      zmin = 0,
      zmax = 10000,
      hoverinfo = "text",
      text = ~hover, 
      locations = ~Country_Code,
      color = n,
      colorscale = "YlOrRd",
      reversescale = TRUE,
      colorbar = list(
                      thickness = 20,  
                      ticklen = 5,
                      len = 1,
                      title = "Population"),
      marker = list(line = l)
    )  %>%
    # Title of the Map
    layout(
      title = 'Immigration Heat Map',
      geo = g
    )
  return(p)
}

