library(dplyr)
library(lubridate)

# read data file
data_file = 'household_power_consumption.txt'

power_consumption <- read.csv(data_file,sep=';', header=TRUE, na.strings = "?")
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")

# get subset of the data
start_date <- '2007-02-01' 
stop_date <-'2007-02-02'

pc_subset <- filter(power_consumption, Date==start_date | Date==stop_date)
pc_subset$DT <- ymd(pc_subset$Date) + hms(pc_subset$Time) 
pc_subset$which_day <- wday(pc_subset$DT, label=TRUE)


# assign plot name and labels
plot_name = 'plot3.png'
y_axis_label <- 'Energy sub metering'

# create plot, save as png with a width of 480 pixels and a height of 480 pixels.

png(plot_name, width = 480, height = 480)

with(pc_subset, plot(DT, Sub_metering_1, type="l", xlab=" ", ylab=y_axis_label, col="black"))

with(pc_subset, lines(DT, Sub_metering_2, col="red"))

with(pc_subset, lines(DT, Sub_metering_3, col="slateblue"))

legend("topright",lty=1, col = c("black","red","slateblue") , legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
