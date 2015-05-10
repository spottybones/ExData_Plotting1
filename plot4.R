# plot4.R
# generate a PNG file containing four plots:
#  1) global active power vs. datetime
#  2) voltage vs. datetime
#  3) three levels of sub metering vs. datetime
#  4) global reactive power vs. datetime
# for the days Feb 1-2, 2007

# ensure required libraries are loaded
library(graphics)
library(grDevices)

# set constants for data
DATA_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
LOCAL_ZIP <- "./data/household_power_consumption.zip"
LOCAL_DATA <- "./data/household_power_consumption.txt"

# download the data file if we don't already have it
if(!file.exists("data")) { dir.create("data") }
if(!file.exists(LOCAL_ZIP)) { download.file(DATA_URL, LOCAL_ZIP, method="curl") }

# unzip the file
unzip(LOCAL_ZIP, exdir="./data")

# read the data into a data frame
full_data <- read.delim(LOCAL_DATA, sep=";", na.strings=c("?"), as.is = c(1, 2))

# subset the data for the dates we want to plot
plot_data <- full_data[full_data$Date == '1/2/2007' | full_data$Date == '2/2/2007',]

# calculate and add a timestamp column
plot_data$datetime <- strptime(paste(plot_data$Date, plot_data$Time),
                                "%d/%m/%Y %H:%M:%S")

# open a PNG file to receive the plot
png(file="plot4.png", width=480, height=480)

# set up grid to hold the four individual plots
par(mfrow = c(2, 2))

# generate the plot
par(cex=0.6)

# generate the plots
with(plot_data, {
  # global active power vs. datetime
  plot(datetime, Global_active_power, type="l",
                     xlab="",
                     ylab="Global Active Power")
 # voltage vs. datetime
 plot(datetime, Voltage, type="l")
 # three sub metering variables vs. datetime
 plot(datetime, Sub_metering_1, type="l", xlab="",
                      ylab="Energy sub metering")
 lines(datetime, Sub_metering_2, col="red")
 lines(datetime, Sub_metering_3, col="blue")
 legend("topright", lty=1, bty="n", col=c("black", "red", "blue"),
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
 # global reactive power vs. datetime
 plot(datetime, Global_reactive_power, type="l")
})

dev.off()

