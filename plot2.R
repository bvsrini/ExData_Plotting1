# Load the required Libraries. 

library(curl)
library(dplyr)

# Download the power consumption data set
curl_download(url= 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile='household_power_consumption.zip')

# Since the file is a zip file , unzio and load the data using the ';' as the delimiter
power_cons_data <- read.delim(unz("household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", as.is = TRUE)

# Subset the data set only for Feb 1 2007 and Feb 2 2007 data 
pcd_subset <- filter(power_cons_data,as.Date(power_cons_data$Date,"%d/%m/%Y") == as.Date("01/02/2007","%d/%m/%Y") | as.Date(power_cons_data$Date,"%d/%m/%Y") == as.Date("02/02/2007","%d/%m/%Y") )

# Since we are required to create a png file. open a png device
png("plot2.png", width = 600, height = 600)

# draw the plot as required setting the labels and colors
plot(x,pcd_subset$Global_active_power,type="l",xlab="",ylab = "Global Active power(kilowatts)")

#set the device off
dev.off()