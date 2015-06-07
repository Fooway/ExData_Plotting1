##set up working directory
setwd("/Users/Michael/Desktop/Codes/")
fileName <- "./exdata-data/household_power_consumption.txt"
##Loading all data
allData <- read.table(fileName, header = TRUE, sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)), na.strings = "?")
##View data in a tabular table
##View(allData)  ##comment out
##head(allData)  ##comment out
attach(allData)
## Obtain 2 days data as required
subDate <- Date == "1/2/2007" | Date == "2/2/2007"
subData <- allData[subDate, ]
attach(subData)
datetime <- paste(Date, Time)
subData$DateTime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
rownames(subData) <- 1:nrow(subData)
attach(subData)
##head(subData)   ##comment out

##output to png with Transparent background
png("plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(2, 2))
## Top-left c(1,1))
plot(subData$DateTime, subData$Global_active_power,  type = "l", xlab = "", ylab = "Global Active Power")
## Top-right c(1,2) 
plot(subData$DateTime, subData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
## Bottom-left c(2,1)
plot(subData$DateTime, subData$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(subData$DateTime, subData$Sub_metering_2, col = "red")
lines(subData$DateTime, subData$Sub_metering_3, col = "blue")
## Setting up legend 
legend("topright", bty = "n", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
## Bottom-right c(2,2)
plot(subData$DateTime, subData$Global_reactive_power, type = "l",col = "black", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()