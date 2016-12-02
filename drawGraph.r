
library(dplyr)

#duplicate code for testing, put it in another file somewhere or whatever.
setYearData<-function(){
  yearIndexes<<-grep("X", colnames(regions))
  yearTable<<-regions[c(1,3,yearIndexes)]
  yearNames<<-as.numeric(gsub("X",x=colnames(regions[yearIndexes]), replacement=""))
}
getCountrySum<-function(){
  #returns The total immigration of each country.
  yearData<-data.frame(regions[yearIndexes],stringsAsFactors=FALSE)
  new.data<-regions %>% select(OdName,Type)
  new.data$mag<- rowSums(regions[yearIndexes], na.rm=TRUE)
  return(new.data)
}
getCountrySumGraph<-function(regions ,year){
  full.regions<<-regions %>% filter(grepl("Total",AreaName))
  
  region.year.indexes<-grep("X", colnames(regions))
  region.year.table<-regions[c(1,3,4,region.year.indexes)] %>%  filter(!grepl("Total",AreaName))
  region.year.table <- region.year.table[,colSums(is.na(region.year.table))<nrow(region.year.table)]
  
  region.year.names<-as.numeric(gsub("X",x=colnames(region.year.table[4:length(region.year.table)]), replacement=""))
  
  country.names<-as.vector(region.year.table$RegName)
  by.years<-as.data.frame(t(region.year.table[5:length(region.year.table)]))
  test.df<<-by.years

  by.years<-cbind(year=rownames(by.years),by.years)
  by.years$year<-gsub(pattern="X",x=by.years$year,replacement="")
  colnames(by.years)<-c("year",country.names)
  test.df2<<-by.years
  
  #rownames(by.years)<-yearTable$OdName
  p<-plot_ly(
    by.years,
    x = ~ year,
    y = ~ by.years[1],
    type = 'bar',
    name = 'Migrants'
  ) %>% 
    layout(title = paste0("Total Immigration Since 1980"))
  for(i in 2:ncol(by.years)){
   p<- p %>% add_trace(y = ~ by.years[,i], name = colnames(by.years)[i]) %>%
    layout(
      barmode = 'stack'
    )
  }
  return(p)
}