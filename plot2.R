plot2 <- function(startDate = "2007-02-01", endDate="2007-02-02") {
  
  data <- read.csv("household_power_consumption.txt", header=T, sep=";")
  data$Date <- as.Date(data$Date,format="%d/%m/%Y")
  
  #We will only be using data from the dates 2007-02-01 and 2007-02-02
  df <- data[(data$Date==startDate) | (data$Date==endDate),]
  
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  
  # First: Mount the timestamp format
  df$Datetime <- with(df, paste(Date, Time))
  # Second : Convert to "POSIXlt" "POSIXt" class
  df$Datetime <- strptime(df$Datetime, "%Y-%m-%d %H:%M:%S")

  plot(df$Datetime,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
  
}