plot5 <- function() {
  setwd("~/devel/repos/ExData_Plotting1")
  library(dplyr)
  library(RColorBrewer)
  require(ggplot2)
  #Have total emissions frequire(dplyr)rerom PM2.5 decreased in the United States from 1999 to 
  #2008? Using the base plotting system, make a plot showing the total PM2.5 
  #emission from all sources for each of the years 1999, 2002, 2005, and 2008
  
  ## This first line will likely take a few seconds. Be patient!
  if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
  }
  if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
  }
   
  baltcitymary.emissions.byyear <- summarise(group_by(filter(NEI, fips == "24510" & type=="ON-ROAD"), year, type), Emissions=sum(Emissions))
  
  png("plot5.png", width=800, height=800)
  clrs <- brewer.pal(4,"Set3")
  g<-ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
    geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions in tons")) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City")+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")
  print(g)
  
  dev.off()
  
  #splt <- split(NEI, NEI$year)
  #data <- with(NEI, tapply(Emissions, year, sum))
  
  #TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
  #barplot(height=TotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions'))
  
  }