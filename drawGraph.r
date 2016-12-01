
library(dplyr)

#duplicate code for testing, put it in another file somewhere or whatever.
yearIndexes<-grep("X", colnames(birthplaces))
yearTable<-birthplaces[c(1,3,yearIndexes)]
yearNames<-as.numeric(gsub("X",x=colnames(birthplaces[yearIndexes]), replacement=""))

getCountrySum<-function(){
  #returns The total immigration of each country.
  yearData<-data.frame(birthplaces[yearIndexes],stringsAsFactors=FALSE)
  new.data<-birthplaces %>% select(OdName,Type)
  new.data$mag<- rowSums(birthplaces[yearIndexes], na.rm=TRUE)
  return(new.data)
}
test.df<-getCountrySum()

getCountrySumGraph<-function(){
  country.names<-as.vector(yearTable$OdName)
  by.years<-as.data.frame(t(yearTable[3:length(yearTable)]))
  by.years<-cbind(year=rownames(by.years),by.years)
  by.years$year<-gsub(pattern="X",x=by.years$year,replacement="")
  colnames(by.years)<-c("year",country.names)
  #rownames(by.years)<-yearTable$OdName
  plot_ly(
    yearTable,
    x = ~ state,
    y = ~ injured,
    type = 'bar',
    name = 'Injured'
  ) %>%
    add_trace(y = ~ killed, name = 'Killed',colors="#df4154") %>%
    layout(
      yaxis = list(title = 'Casualties'),
      xaxis = list(title = "State") ,
      barmode = 'stack'
    ) %>% 
    layout(title = paste0("Total Immigration Since 1980"))
  
}