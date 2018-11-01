
#set working directory
setwd("~/Google Drive/Coursera/Getting_cleaning_data/Exploratory Data Analysis")

#Create data directory
if (!dir.exists("./data")) {
  dir.create("data")
} 
 
#download zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"./data/household_power_consumption.zip")
  
#example for doing with one action did not work because temp could not find file
#urlcoP <- "http://www.cophieu68.vn/datax123456/metastock_all_data.zip"
#temp <- tempfile()
#download.file(urlcoP,temp)
#data <- read.table(unz(temp, "metastock_all_data.txt"))


#File contained ";" character as a separator. Running without the sep flag created a one variable file.
#Also header flag needed to be set to get the variables
#Went with na.strings to create numeric variables.
power <-read.table("household_power_consumption 2.txt", sep= ";" ,stringsAsFactors = FALSE, header = TRUE, na.strings = "?")

#Get values for Feb 1 and 2 of 2007
combineddata <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]

#close any open devices and parameters

#set date/time
datetime <- strptime(paste(combineddata$Date, combineddata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalActivePower <- as.numeric(combineddata$Global_active_power)
globalReactivePower <- as.numeric(combineddata$Global_reactive_power)
voltage <- as.numeric(combineddata$Voltage)
subMetering1 <- as.numeric(combineddata$Sub_metering_1)
subMetering2 <- as.numeric(combineddata$Sub_metering_2)
subMetering3 <- as.numeric(combineddata$Sub_metering_3)

plot.new()

#Create png file
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
