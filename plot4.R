##===========================================
## Cousera - Data Science Specialization
#
## Exploratory Data Analysis - Week 1
##    Course Project - Plot3
## 
## Purpose: Save a graph in PNG format 480x480
## Data: Household power consumption
## From website https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption


library(dplyr)
library(data.table)

f = "./household_power_consumption.txt"
hpc = fread(f, sep=";", header=TRUE, na.strings = "?", stringsAsFactors = FALSE)

## Select only the period between 2007-02-01 and 2007-02-02
hpc = hpc[as.Date(hpc$Date, "%d/%m/%Y") %in% seq(as.Date("2007-02-01"), as.Date("2007-02-02"), 1),]

## Add a column with the week days
hpc = mutate(hpc, weekday = weekdays(as.Date(hpc$Date, "%d/%m/%Y")))
hpc = mutate(hpc, datetime = paste(hpc$Date, hpc$Time, sep=" "))

## Paint Window to see if graph is adjusting correctly
windows(12,12)

## Set graph view to 2 x 2
par(mfrow=c(2,2))

## 1st graph : Global active power per time series
with(hpc, plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), 
               Global_active_power, type="l", xlab="", ylab="Global Active Power"))

## 2nd graph : voltage per time series
with(hpc, plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), 
               Voltage, type="l", xlab="datetime", ylab="Voltage"))

## Paint line graph
with(hpc, plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), 
               Sub_metering_1, type="l", xlab="", ylab="Sub Metering"))
lines(strptime(hpc$datetime, "%d/%m/%Y %H:%M:%S"), hpc$Sub_metering_2, col="red" )
lines(strptime(hpc$datetime, "%d/%m/%Y %H:%M:%S"), hpc$Sub_metering_3, col="blue" )
legend("topright", legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), cex=1, col=c("black","red","blue"), lwd=c(2,2,2))

## 4th graph : Global reactive power per time series
with(hpc, plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), 
               Global_reactive_power, type="l", xlab="datetime"))


## Save as Portable Network Graphics
dev.copy(png, file = "./plot4.png", width=480, height=480, units="px")
dev.off()
