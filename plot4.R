plot4 <- function() {
  setwd("~/devel/repos/ExData_Plotting1")
  library(dplyr)
  library(RColorBrewer)
  require(ggplot2)
  require(stringr)
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
   
  # regex
  combustion.coal <- filter(SCC, str_detect(EI.Sector, "Fuel Comb.*Coal"))
  
  # Find emissions from coal combustion-related sources
  emissions.coal.combustion <- inner_join(NEI, combustion.coal)
  emissions.coal.related <- summarise(group_by(emissions.coal.combustion, year), Emissions=sum(Emissions))
  
  png("plot4.png", width=800, height=800)
  
  g <- ggplot(emissions.coal.related, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
    geom_bar(stat="identity") +
    #geom_bar(position = 'dodge')+
    # facet_grid(. ~ year) +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
    ggtitle("Emissions from coal combustion-related sources in kilotons")+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")
  print(g)
  dev.off()
  
  
  #splt <- split(NEI, NEI$year)
  #data <- with(NEI, tapply(Emissions, year, sum))
  
  #TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
  #barplot(height=TotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions'))
  
  }