plot4 <- function(startDate = "2007-02-01", endDate="2007-02-02") {
  
  #library("readr")
  data <- read.csv("household_power_consumption.txt", header=T, sep=";")
  #datar <- read_delim("household_power_consumption.txt", delim=";")
  
  data$Date <- as.Date(data$Date,format="%d/%m/%Y")
  
  #We will only be using data from the dates 2007-02-01 and 2007-02-02
  df <- data[(data$Date==startDate) | (data$Date==endDate),]
  
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  
  # Define 2x2 grid
  par(mfrow=c(2,2))
  
  #Plot 1
  plot(df$Datetime,df$Global_active_power, type="l", xlab="datetime", ylab="Global Active Power")
  #Plot 2
  plot(df$Datetime,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
  #Plot 3
  plot(df$Datetime,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(df$Datetime, df$Sub_metering_2, col="red")
  lines(df$Datetime, df$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  #Plot 4
  plot(df$Datetime,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  
}