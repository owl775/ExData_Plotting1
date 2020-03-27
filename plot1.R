library(dplyr)

# read data file
data_file = 'household_power_consumption.txt'

power_consumption <- read.csv(data_file,sep=';', header=TRUE, na.strings = "?")
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")


# get subset of the data
start_date <- '2007-02-01' 
stop_date <-'2007-02-02'

pc_subset <- filter(power_consumption, Date==start_date | Date==stop_date)

# assign plot name and labels
plot_name = 'plot1.png'
main_title <- 'Global Active Power'
x_axis_label <- 'Global Active Power (kilowatts)'
y_axis_label <- 'Frequency'


# create plot, save as png with a width of 480 pixels and a height of 480 pixels.

png(plot_name, width = 480, height = 480)
hist(pc_subset$Global_active_power, col = "red", main=main_title, xlab=x_axis_label)
dev.off()

