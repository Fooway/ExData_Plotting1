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

##output to png the Global Active Power histogram plot with Transparent background
png("plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(subData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()