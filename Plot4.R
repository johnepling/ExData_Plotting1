# Plot 4 - EDA Project 1

# load packages
library(tidyverse)
library(lubridate)

# get data, read data in
setwd("/Users/johnepling/OneDrive/_Work/DSSExploratoryDataAnalysis/ExData_Plotting1")
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataurl, "dataset.zip")
unzip("dataset.zip")
powerdata <- read_csv2("household_power_consumption.txt", na = "?")

# clean data and limit to applicable dates
powerdata$dt <- paste(powerdata$Date, powerdata$Time)
powerdata$dt <- dmy_hms(powerdata$dt, tz = "America/Los_Angeles")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

#final dataset
projdata <- filter(powerdata, date(powerdata$dt) == "2007-02-01" | date(powerdata$dt) == "2007-02-02")
rm(powerdata)

# create plot on PNG device
png(file = "plot4.png", width = 480, height = 480, units = "px")

# set up 2x2 plot
par(mfrow = c(2,2))
with(projdata, {
    # plot 1-1
    plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    
    # plot 1-2
    plot(dt, Voltage/1000, type = "l", xlab = "datetime", ylab = "Voltage")
    
    # plot 2-1
    plot(dt, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
    lines(dt, Sub_metering_2, type = "l", col = "red")
    lines(dt, Sub_metering_3, type = "l", col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, box.lty = 0)

     # plot 2-2
     plot(dt, Global_reactive_power, type = "l", xlab = "datetime")
     }
)
dev.off()  # I will forget this someday, but not today!

# clean up
file.remove("dataset.zip")
file.remove("household_power_consumption.txt")
setwd("/Users/johnepling/OneDrive/_Work/DSSExploratoryDataAnalysis")
