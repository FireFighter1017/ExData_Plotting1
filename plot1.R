##===========================================
## Cousera - Data Science Specialization
#
## Exploratory Data Analysis - Week 1
##    Course Project - Plot1
## 
## Purpose: Save a graph in PNG format 480x480
## Data: Household power consumption
## 
## From website https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
## I could define that column separator is ";"
## So here we go:

library(dplyr)
library(data.table)
f = "./household_power_consumption.txt"
hpc = fread(f, sep=";", header=TRUE, na.strings = "?", stringsAsFactors = FALSE)

## Select only the period between 2007-02-01 and 2007-02-02
hpc = hpc[as.Date(hpc$Date, "%d/%m/%Y") %in% seq(as.Date("2007-02-01"), as.Date("2007-02-02"), 1),]

## Create a list of numeric conversions of Global_active_power values
GAPkw = hpc$Global_active_power[!is.na(hpc$Global_active_power)]

## Paint histogram
hist(GAPkw, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", xlim=c(0,6), ylim=c(0,1200))

## Save as Portable Network Graphics
dev.copy(png, file = "./plot1.png", width=480, height=480, units="px")
dev.off()
