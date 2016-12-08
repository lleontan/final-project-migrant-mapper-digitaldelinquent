# Required library
library(dplyr)

grepYearIndexes <- function(data.set) {
  #returns vector of year indexes for the given dataset.
  return(grep("X", colnames(data.set)))
}
getCountrySum <- function(birthplaces) {
  #Returns a dataset with an appended column for total immigrants.
  new.data <-
    data.frame(birthplaces[, c(1, 3, 5, 9, grepYearIndexes(birthplaces))],
               stringsAsFactors = FALSE)
  new.data$mag <- rowSums(new.data[grep("X", colnames(new.data))],
                          na.rm = TRUE)
  new.data <- new.data %>% arrange(-mag)
  return(new.data)
}
largestContributorsGraph <- function(countries.count, birthplaces) {
  # Returns a plotly piechart of the top immigrant countries percentage.
  countries.count = countries.count + 1
  show.percent = "percent"
  if (countries.count > 22) {
    show.percent = "none"
  }
  
  # Appends the total number of immigrants to each country.
  # Arranges by decending magnitude.
  countries <- getCountrySum(birthplaces)
  
  # The row containing total stats.
  worldData <- countries %>% filter(OdName == "Total")
  
  # Getting the top countries excluding total.
  top.countries <- countries[1:countries.count, ] %>%
    filter(OdName != "Total")
  # Getting year indexes with total immigrants.
  top.countries.indexes <-
    c(grepYearIndexes(top.countries),length(top.countries))
  
  # Getting difference between top countries and all countries.
  worldData[top.countries.indexes] <-
    worldData[top.countries.indexes] -
    colSums(top.countries[top.countries.indexes],
            na.rm = TRUE)
  
  # Adding difference as a column to top.countries.
  worldData$OdName <- "All Other"
  top.countries <- rbind(worldData, top.countries)
  
  # plotting graph.
  p <- plot_ly(
    top.countries,
    labels =  ~ OdName,
    values =  ~ mag,
    type = "pie",
    showlegend = FALSE,
    textinfo = show.percent
  ) %>%
    layout(
      title = paste0(
        'Immigrants since 1980:',
        filter(countries, OdName == "Total")$mag
      ),
      xaxis = list(
        showgrid = FALSE,
        zeroline = FALSE,
        showticklabels = FALSE
      ),
      yaxis = list(
        showgrid = FALSE,
        zeroline = FALSE,
        showticklabels = FALSE
      )
    )
  return(p)
}
getCountrySumGraph <- function(regions, countries.name) {
  # Returns stacked barchart with line traces for given country.
  # Takes dataset containing regions,
  # Takes string country to trace.
  
  region.year.indexes <-grepYearIndexes(regions)
  
  # Cleaning regions.
  region.year.table <- regions[c(1, 3, 4, region.year.indexes)] %>%
    filter(!grepl("Total", AreaName)) %>%
    arrange(X2012)
  
  # Removing NA columns.
  region.year.table <-
    region.year.table[, colSums(is.na(region.year.table))
                      < nrow(region.year.table)]
  
  country.names <- as.vector(region.year.table$RegName)
  # Transposing dataframe.
  by.years <- as.data.frame(t(
    region.year.table[4:length(region.year.table)]))
  
  # Adding year column of years.
  by.years <- cbind(year = rownames(by.years), by.years)
  
  # Cleaning up year column.
  by.years$year <- gsub(pattern = "X",
                        x = by.years$year,
                        replacement = "")
  # Adding sum column for each year.
  by.years$sum <- rowSums(by.years[, 3:length(by.years)], na.rm = TRUE)
  colnames(by.years) <- c("year", country.names, "sum")
  
  # Adding column for the specified country.
  m.col <- birthplaces %>% filter(OdName == countries.name)
  m.col <- m.col %>%  select(grepYearIndexes(m.col)) %>% as.vector()
  by.years[[countries.name]] <-
    as.numeric(m.col[1, 1:nrow(by.years)])
  
  #Plotting bargraph.
  p <- plot_ly(
    by.years,
    x = ~ year,
    y = ~ by.years[1],
    type = 'bar',
    showlegend = FALSE
  ) %>%
    add_trace(
      x =  ~ year,
      y =  ~ sum,
      type = 'scatter',
      mode = 'lines',
      name = 'All',
      line = list(color = '#3a00e9')
    )

  p <- p %>%
    layout(
      title = paste0("US Immigration Since 1980"),
      barmode = "stack",
      hovermode = "closest",
      xaxis = list(
        title = '',
        tickangle = 55,
        ticks = "outside",
        ticklen = 2
      ),
      yaxis = list(title = "Immigrants")
    )
  colRange <- 2:(ncol(by.years) - 2)
  
  # Adding each region as stacked bar.
  for (i in colRange) {
    p <- p %>% add_trace(y =  by.years[, i],
                      name = colnames(by.years)[i],
                      showlegend = FALSE)
  }
  # Adding country trace.
  if (countries.name != "None") {
    p <- p %>% add_trace(
      x =  ~ year,
      y =  ~ by.years[, countries.name],
      type = 'scatter',
      mode = 'lines',
      name = countries.name,
      line = list(color = '#000000'
                  , width = 5)
    )
  }
  return(p)
}

#Gets vector of countries without total or unknown
getCountriesWithoutTotals<-function(){
  set<-getCountrySum(birthplaces) %>% filter(OdName!="Total") %>% filter(OdName!="Unknown")
  return(as.vector(set$OdName))
}

# Given a country name returns summary information.
getCountryInformation <- function(country) {
  target.country <- getCountrySum(birthplaces) %>% filter(OdName == country)
  info<- paste0(
    "The total amount of immigrants from ",
    country,
    " between the years of 1980-2013 is ",
    target.country$mag,
    ". The nation of ",
    country,
    " is a ",
    target.country$DevName,
    " in ",
    target.country$AreaName,
    "."
  )
  if(country=="Total"){
    info<-paste0("From 1980 to 2013, ",target.country$mag," immigrants arrived in the United States.")
  } else if(country=="Unknown"){
    info<-paste0("From 1980 to 2013, ",target.country$mag," immigrants arrived from unknown locations in the United States.")
  }
  return(info)
}
