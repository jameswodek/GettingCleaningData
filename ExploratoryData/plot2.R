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

#plot the graph
plot(epcdata2_feb$DT, epcdata2_feb$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")

#copy/create the png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
