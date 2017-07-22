plot1 <- function(startDate = "2007-02-01", endDate="2007-02-02") {

  #library("readr")
  data <- read.csv("household_power_consumption.txt", header=T, sep=";")
  #datar <- read_delim("household_power_consumption.txt", delim=";")
  
  data$Date <- as.Date(data$Date,format="%d/%m/%Y")
  
  #We will only be using data from the dates 2007-02-01 and 2007-02-02
  df <- data[(data$Date==startDate) | (data$Date==endDate),]
  
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  
  with(df, hist(Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")) 
  #with(datar, hist(Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)"))
  
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  
}