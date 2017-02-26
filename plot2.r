##===========================================
## Cousera - Data Science Specialization
#
## Exploratory Data Analysis - Week 1
##    Course Project - Plot2
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

## Paint line graph
with(hpc, plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), 
               Global_active_power, type="l", xlab="", ylab="Global Active Power"))

## Save as Portable Network Graphics
dev.copy(png, file = "./plot2.png", width=480, height=480, units="px")
dev.off()
