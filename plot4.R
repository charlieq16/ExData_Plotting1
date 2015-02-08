# read in household power consumption and plot a histogram of the 
# global active power for 2007-01-01 & 2007-02=02

# make sure we are in the right directory
setwd("~/coursera/explore/ExData_Plotting1")
library(data.table)


filename <- "household_power_consumption.txt"

# if we have already downloaded the file do not do it again
# if the file does not exist fetch it and unzip
if (file.exists(filename) == FALSE) {
  zipname = "household_power_consumption.zip"
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=zipname, method="curl")
  unzip(zipname)
}

data <- fread(filename)

# clean up the data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

twoDays <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02"]
twoDays <- data.frame(twoDays)

for (i in c(3:9)) {
  twoDays[,i] <- as.numeric(as.character(twoDays[,i]))
}

# make the datetime value
twoDays$Date_Time <- paste(twoDays$Date, twoDays$Time)
twoDays$Date_Time <- strptime(twoDays$Date_Time, "%Y-%m-%d %H:%M:%S")

# plot 4

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
# 2x2 chart matrix: row order
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)

# top left
plot(twoDays$Date_Time, twoDays$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")
lines(twoDays$Date_Time, twoDays$Global_active_power, type="S")

# top right
plot(twoDays$Date_Time, twoDays$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
lines(twoDays$Date_Time, twoDays$Voltage, type="S")

# bottom left
plot(twoDays$Date_Time, twoDays$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(twoDays$Date_Time, twoDays$Sub_metering_1, col = "black", type = "S")
lines(twoDays$Date_Time, twoDays$Sub_metering_2, col = "red", type = "S")
lines(twoDays$Date_Time, twoDays$Sub_metering_3, col = "blue", type = "S")
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right
plot(twoDays$Date_Time, twoDays$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
lines(twoDays$Date_Time, twoDays$Global_reactive_power, type="S")

dev.off()
