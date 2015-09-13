#load the dplyr package for subsetting the data
library(dplyr)

#load the data from your local working directory
epcdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#create a data frame table through the dplyr function tbl_df
epcdata2 <- tbl_df(epcdata)

#subset february data
epcdata2_feb <- filter(epcdata2, Date %in% c("1/2/2007", "2/2/2007"))

#I learned the hard way that you need to concatenate the Date and Time columns
#this will then populate the X axis
epcdata2_feb$DT = paste(epcdata2_feb$Date, epcdata2_feb$Time)
epcdata2_feb$DT = as.POSIXct(strptime(epcdata2_feb$DT, "%d/%m/%Y %H:%M:%S"))

#Create a blank graph with the proper rows and columns for the 4 graphs
#png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

#Plot the 4 graphs
#Graph1
plot(epcdata2_feb$DT, epcdata2_feb$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

#Graph2
plot(epcdata2_feb$DT, epcdata2_feb$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Graph3
plot(epcdata2_feb$DT, epcdata2_feb$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy Submetering")
lines(epcdata2_feb$DT, epcdata2_feb$Sub_metering_2, type="l", col="red")
lines(epcdata2_feb$DT, epcdata2_feb$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#Graph4
plot(epcdata2_feb$DT, epcdata2_feb$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
