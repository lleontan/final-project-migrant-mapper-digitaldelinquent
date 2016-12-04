
library(dplyr)

#duplicate code for testing, put it in another file somewhere or whatever.
setYearData<-function(){
  yearIndexes<<-grep("X", colnames(regions))
  yearTable<<-regions[c(1,3,yearIndexes)]
  yearNames<<-as.numeric(gsub("X",x=colnames(regions[yearIndexes]), replacement=""))
}
getCountrySum<-function(){
  #Returns The total immigration of each country.
  yearData<-data.frame(regions[yearIndexes],stringsAsFactors=FALSE)
  new.data<-regions %>% select(OdName,Type)
  new.data$mag<- rowSums(regions[yearIndexes], na.rm=TRUE)
  return(new.data)
}
getCountrySumGraph<-function(regions ,selectedYear){
  full.regions<<-regions %>% filter(grepl("Total",AreaName))
  
  region.year.indexes<-grep("X", colnames(regions))
  region.year.table<-regions[c(1,3,4,region.year.indexes)] %>% 
    filter(!grepl("Total",AreaName)) %>% 
    arrange(X1991)
  region.year.table <- region.year.table[,colSums(is.na(region.year.table))<nrow(region.year.table)]
  
  region.year.names<-as.numeric(gsub("X",x=colnames(region.year.table[3:length(region.year.table)]), replacement=""))
  
  country.names<-as.vector(region.year.table$RegName)
  by.years<-as.data.frame(t(region.year.table[4:length(region.year.table)]))

  by.years<-cbind(year=rownames(by.years),by.years)
  by.years$year<-gsub(pattern="X",x=by.years$year,replacement="")
  by.years$sum<-rowSums(by.years[,3:length(by.years)],na.rm = TRUE)
  colnames(by.years)<-c("year",country.names,"sum")
  by.years<-by.years #%>% filter(year==selectedYear)

  #rownames(by.years)<-yearTable$OdName
  p<-plot_ly(
    by.years,
    x = ~ year,
    y = ~ by.years[1],
    type = 'bar',
    showlegend = FALSE
  ) %>%
    add_trace(
      x=~year,
      y=~sum,
      type = 'scatter',
      mode = 'lines',
      name = '',
      line = list(color = '#45171D')
      )%>% 
    layout(title = paste0("US Immigration Since 1980"),barmode="stack",
           hovermode="closest",
           xaxis=list(
             tickangle = 55,
             ticks = "outside",
             ticklen = 2
           ),
           yaxis=list(
             title = "Immigrants"
           ))
  colRange<-2:(ncol(by.years)-1)
  
  for(i in colRange){
   p<- p %>% add_trace(y =  by.years[,i], name = colnames(by.years)[i],showlegend = FALSE)
  }
  return(p)
}
