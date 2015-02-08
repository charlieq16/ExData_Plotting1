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

# plot 1

png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))

hist(twoDays$Global_active_power,col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
