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

# generate the plot
