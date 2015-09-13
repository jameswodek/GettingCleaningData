##load the dplyr package for subsetting the data
library(dplyr)

##load the data from your local working directory
epcdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
epcdata2 <- tbl_df(epcdata)
epcdata2_feb <- filter(epcdata2, Date %in% c("1/2/2007", "2/2/2007"))

hist(epcdata2_feb$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
