
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
power <-read.table("household_power_consumption 2.txt", sep= ";" ,stringsAsFactors = FALSE, header = TRUE)

#Get values for Feb 1 and 2 of 2007
combineddata <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]

#close any open devices and parameters
plot.new()


globalActivePower <- as.numeric(subSetData$Global_active_power)

#create png file
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power (Kilowatts)", xlab="Global Active Power (kilowatts)")

#close device
dev.off()


