## Exploratory Data Analysis
## Course Project
## Assignment 1
## 5 November 2015
## written by Yusuke Takeuchi

#----------------------------------------------------------------------------------
# Set working environment
#----------------------------------------------------------------------------------
Sys.setlocale(category = "LC_ALL", locale = "english")

if (!file.exists("./data")){
    dir.create("./data")
}
# setwd("/Users/bamboomeat/Documents/R/Coursera/Exploratory Data Analysis/")
setwd(paste(getwd(),"/data", sep =""))

#----------------------------------------------------------------------------------
# Get and clean data
#----------------------------------------------------------------------------------
if(!file.exists("household_power_consumption.txt")){
    temp <- tempfile()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = temp)
    source_file <- unzip(temp)
    unlink(temp)
} else {
    source_file <- "household_power_consumption.txt"
}

## read data
data <- read.table(source_file, header = TRUE, sep = ";")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## extract the data for the assignment
dataNew <- data[data$Date == "2007-2-1", ]
dataNew <- rbind(dataNew, data[data$Date == "2007-2-2",])
dataNew <- cbind(dataNew, TimeStamp = as.POSIXct(paste(dataNew$Date, dataNew$Time)))

## convert data to "numeric" through "character"
dataNew$Global_active_power <- as.numeric(as.character(dataNew$Global_active_power))
dataNew$Global_reactive_power <- as.numeric(as.character(dataNew$Global_reactive_power))
dataNew$Voltage <- as.numeric(as.character(dataNew$Voltage))
dataNew$Sub_metering_1 <- as.numeric(as.character(dataNew$Sub_metering_1))
dataNew$Sub_metering_2 <- as.numeric(as.character(dataNew$Sub_metering_2))
dataNew$Sub_metering_3 <- as.numeric(as.character(dataNew$Sub_metering_3))

#----------------------------------------------------------------------------------
# Plot 2
#----------------------------------------------------------------------------------
png("plot2.png", width = 480, height = 480)
plot(dataNew$TimeStamp, dataNew$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

# Code ends here
