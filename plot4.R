plot4 <- function() {
  setwd("~/devel/repos/ExData_Plotting1")
  require(dplyr)
  require(RColorBrewer)
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
  emissions.coal.related <- summarise(group_by(emissions.coal.combustion, year, type), Emissions=sum(Emissions))
  
  png("plot4.png", width=800, height=800)
  
  g<- qplot(year, Emissions, data=emissions.coal.related, color=type, geom="line") + 
    #stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + 
    #geom_line(aes(size="total", shape = NA)) + 
    ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) +
    ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
  print(g)
  dev.off()
  
  
  #splt <- split(NEI, NEI$year)
  #data <- with(NEI, tapply(Emissions, year, sum))
  
  #TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
  #barplot(height=TotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions'))
  
  }