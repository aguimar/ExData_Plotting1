plot6 <- function() {
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
   
  baltcitymary.emissions <- summarise(group_by(filter(NEI, fips == "24510" & type=="ON-ROAD"), year, type), Emissions=sum(Emissions))
  losangelscal.emissions <- summarise(group_by(filter(NEI, fips == "06037" & type=="ON-ROAD"), year, type), Emissions=sum(Emissions))
  
  baltcitymary.emissions$County <- "Baltimore City, MD"
  losangelscal.emissions$County <- "Los Angeles County, CA"
  both.emissions <- rbind(baltcitymary.emissions, losangelscal.emissions)
  
  png("plot6.png", width=800, height=800)
  clrs <- brewer.pal(4,"Set3")
  g<-ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
    geom_bar(stat="identity") + 
    #facet_grid(County~., scales="free") +
    facet_grid(County~., scales="fixed") +
    
    ylab(expression("total PM"[2.5]*" emissions in tons")) + 
    xlab("year") +
    ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
    geom_label(aes(fill = County),colour = "white", fontface = "bold")
  print(g)
  dev.off()
  
  #splt <- split(NEI, NEI$year)
  #data <- with(NEI, tapply(Emissions, year, sum))
  
  #TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
  #barplot(height=TotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions'))
  
  }