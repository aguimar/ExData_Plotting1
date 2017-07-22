plot3 <- function() {
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
   
  baltcitymary.emissions.byyear <- summarise(group_by(filter(NEI, fips == "24510"), year, type), Emissions=sum(Emissions))
  
  png("plot3.png", width=800, height=800)
  clrs <- brewer.pal(4,"Set3")
  x1<- ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
    geom_bar(stat="identity") +
    #geom_bar(position = 'dodge')+
    facet_grid(. ~ type) +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emission in tons")) +
    ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                       "City by various source types", sep="")))+
    geom_label(aes(fill = type), colour = "white", fontface = "bold")
  
  print(x1)
  dev.off()
  
  #splt <- split(NEI, NEI$year)
  #data <- with(NEI, tapply(Emissions, year, sum))
  
  #TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
  #barplot(height=TotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions'))
  
  }