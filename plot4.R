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
plot_name = 'plot4.png'

# create plot, save as png with a width of 480 pixels and a height of 480 pixels.
png(plot_name, width = 480, height = 480)
par(mfrow = c(2, 2))

# subplot_1
s1_y_label <- 'Global Active Power'
plot(pc_subset$DT , pc_subset$Global_active_power, type="l", xlab=" ", ylab=s1_y_label)

# subplot_2
s2_y_label <- 'Voltage'
plot(pc_subset$DT , pc_subset$Voltage, type="l", ylab=s2_y_label, xlab="datetime")


# subplot_3
s3_y_label <- 'Energy sub metering'

with(pc_subset, plot(DT, Sub_metering_1, type="l", xlab=" ", ylab=s3_y_label, col="black"))
with(pc_subset, lines(DT, Sub_metering_2, col="red"))
with(pc_subset, lines(DT, Sub_metering_3, col="slateblue"))
legend("topright",lty=1, col = c("black","red","slateblue") , legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty=0)


# subplot 4
s4_y_label <- 'Global_reactive_power'
plot(pc_subset$DT , pc_subset$Global_reactive_power, type="l", ylab=s4_y_label, xlab="datetime")


# turn off plotting device
dev.off()
