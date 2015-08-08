# Load the required Libraries. 

library(curl)
library(dplyr)

# Download the power consumption data set
curl_download(url= 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile='household_power_consumption.zip')

# Since the file is a zip file , unzip and load the data using the ';' as the delimiter
power_cons_data <- read.delim(unz("household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", as.is = TRUE)

# Subset the data set only for Feb 1 2007 and Feb 2 2007 data 
pcd_subset <- filter(power_cons_data,as.Date(power_cons_data$Date,"%d/%m/%Y") == as.Date("01/02/2007","%d/%m/%Y") | as.Date(power_cons_data$Date,"%d/%m/%Y") == as.Date("02/02/2007","%d/%m/%Y") )

# Since we are required to create a png file. open a png device
png("plot4.png", width = 600, height = 600)

# draw the all the 4 plot as required setting the labels and colors. It was required to set the margins correctly else the legend on # the 3rd plot was not working correctly

par(mfrow = c(2,2),mar = c(4,4,2,1),lwd = 0.5)

with (pcd_subset, 
{
        plot(x,pcd_subset$Global_active_power,type="l",xlab="",ylab = "Global Active power(kilowatts)")
        plot(x,pcd_subset$Voltage,type="l",xlab="date/time",ylab = "Voltage")
        plot(x,Sub_metering_1,type = "l",xlab = "",ylab = "Energy sub metering") 
        lines(x,Sub_metering_2 , type = "l",col = "red") 
        lines(x,Sub_metering_3 , type = "l", col = "blue")
        legend ("topright",lty= c(1,1,1),lwd = c(2,2,2), col = c("black","red","blue"),bty = "n",xjust = 1,cex = 0.8,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        plot(x,Global_reactive_power,type="l",xlab="date/time")
})


#set the device off
dev.off()