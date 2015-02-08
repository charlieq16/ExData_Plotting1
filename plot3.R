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

# plot 3

png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(7, 6, 5, 4))

plot(twoDays$Date_Time, twoDays$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(twoDays$Date_Time, twoDays$Sub_metering_1, col = "black", type = "S")
lines(twoDays$Date_Time, twoDays$Sub_metering_2, col = "red", type = "S")
lines(twoDays$Date_Time, twoDays$Sub_metering_3, col = "blue", type = "S")

legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Adds a legend with lines
# lwd = c(1, 1, 1) assigns the lines widths of 1
# lty = c(1, 1) assigns the line type within the legend

dev.off()
