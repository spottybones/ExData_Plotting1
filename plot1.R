# plot1.R
# generate a PNG file containing a plot of a histogram showing frequency
# of Global Active Power observations from the supplied household power consumption
# database for 2/1/2007 - 2/2/2007

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

# open a PNG file to receive the plot
png(file="plot1.png", width=504, height=504, res=96)

# generate the plog and close the file
par(cex=0.8)
hist(plot_data$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)"
     )
dev.off()

