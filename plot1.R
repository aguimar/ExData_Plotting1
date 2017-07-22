plot1 <- function() {
  setwd("~/devel/repos/ExData_Plotting1")
  library(dplyr)
  library(RColorBrewer)
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
   
  total.emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
  
  png("plot1.png", width=800, height=800)
  clrs <- brewer.pal(4,"Set3")

  x1<-barplot(height=total.emissions$Emissions/1000, names.arg=total.emissions$year,
              xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,8000),
              main=expression('Total PM'[2.5]*' emissions at various years in kilotons'),col=clrs)
  ## Add text at top of bars
  text(x = x1, y = round(total.emissions$Emissions/1000,2), label = round(total.emissions$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
  dev.off()
  
  #splt <- split(NEI, NEI$year)
  #data <- with(NEI, tapply(Emissions, year, sum))
  
  #TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
  #barplot(height=TotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions'))
  
  }