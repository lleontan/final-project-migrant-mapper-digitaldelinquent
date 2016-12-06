
library(dplyr)

#duplicate code for testing, put it in another file somewhere or whatever.
setYearData<-function(){
  yearIndexes<<-grep("X", colnames(regions))
  yearTable<<-regions[c(1,3,yearIndexes)]
  yearNames<<-as.numeric(gsub("X",x=colnames(regions[yearIndexes]), replacement=""))
}
grepYearIndexes<-function(data.set){
  #returns vector of year indexes
  return(grep("X", colnames(data.set)))
}
getCountrySum<-function(){
  #Returns The total immigration of each country.
  new.data<-data.frame(birthplaces[,c(1,3,5,9,grepYearIndexes(birthplaces))],stringsAsFactors=FALSE)
  new.data$mag<- rowSums(new.data[grep("X", colnames(new.data))], na.rm=TRUE)
  new.data<-new.data %>% arrange(-mag)
  return(new.data)
}
largestContributorsGraph<-function(countries.count){
  countries.count=countries.count+1
  show.percent="percent"
  if(countries.count>22){
    show.percent = "none"
  }
  countries<-getCountrySum()
  worldData<- countries %>% filter(OdName=="Total")
  top.countries<-countries[1:countries.count,] %>% filter(OdName!="Total")
  top.countries.indexes<-c(grep("X", colnames(top.countries)),length(top.countries))
  worldData[top.countries.indexes]<-
    worldData[top.countries.indexes]-
    colSums(top.countries[top.countries.indexes],na.rm = TRUE)
  worldData$OdName<-"All Other"
  top.countries<-rbind(worldData,top.countries)
  p<-plot_ly(top.countries,
             labels=~OdName,
             values=~mag,
             type="pie",
             showlegend = FALSE,
             textinfo=show.percent
            ) %>%
    layout(title = paste0('Immigrants since 1980:',  filter(countries,OdName=="Total")$mag),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  return(p)
}
getCountrySumGraph<-function(regions){
  full.regions<<-regions %>% filter(grepl("Total",AreaName))
  
  region.year.indexes<-grep("X", colnames(regions))
  region.year.table<-regions[c(1,3,4,region.year.indexes)] %>% 
    filter(!grepl("Total",AreaName)) %>% 
    arrange(X2012)
  region.year.table <- region.year.table[,colSums(is.na(region.year.table))<nrow(region.year.table)]
  
  region.year.names<-as.numeric(gsub("X",x=colnames(region.year.table[3:length(region.year.table)]), replacement=""))
  
  country.names<-as.vector(region.year.table$RegName)
  by.years<-as.data.frame(t(region.year.table[4:length(region.year.table)]))

  by.years<-cbind(year=rownames(by.years),by.years)
  by.years$year<-gsub(pattern="X",x=by.years$year,replacement="")
  by.years$sum<-rowSums(by.years[,3:length(by.years)],na.rm = TRUE)
  colnames(by.years)<-c("year",country.names,"sum")
  
  mexico.col<-birthplaces %>% filter(OdName=="Mexico")
  mexico.col<-mexico.col %>%  select(grepYearIndexes(mexico.col)) %>% as.vector()
  by.years<- by.years %>% mutate(mexico=as.numeric(mexico.col[1,1:nrow(by.years)]))#%>% filter(year==selectedYear)
  
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
      name = 'All',
      line = list(color = '#45171D')
      ) %>% add_trace(
    x=~year,
    y=~mexico,
    type = 'scatter',
    mode = 'lines',
    name = 'Mexico',
    line = list(color = '#3a00e9'
                ,width=3
                )
  ) %>% 
    layout(title = paste0("US Immigration Since 1980"),barmode="stack",
           hovermode="closest",
           xaxis=list(
             title = '',
             tickangle = 55,
             ticks = "outside",
             ticklen = 2
           ),
           yaxis=list(
             title = "Immigrants"
           ))
  colRange<-2:(ncol(by.years)-2)
  
  for(i in colRange){
   p<- p %>% add_trace(y =  by.years[,i], name = colnames(by.years)[i],showlegend = FALSE)
  }
  
  return(p)
}
