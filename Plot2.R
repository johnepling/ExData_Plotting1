## Plot 2 for EDA Project 1

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
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(projdata$dt, projdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()  # I will forget this someday, but not today!

# clean up
file.remove("dataset.zip")
file.remove("household_power_consumption.txt")
setwd("/Users/johnepling/OneDrive/_Work/DSSExploratoryDataAnalysis")