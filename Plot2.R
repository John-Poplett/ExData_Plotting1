library(sqldf)

#
# Use the sqldf library to pull in observations from date range of interest
#
df <- read.csv.sql(
  "household_power_consumption.txt", 
  "select * from file where Date='1/2/2007' or Date='2/2/2007'", 
  sep = ";"
)

# Convert date into a Posix time object  
df$Date <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

#
# Specify the height and width per project instructions
#
png(filename = "Plot2.png", width = 480, height = 480, bg = "white")

#
# Draw a simple line plot, specify X and Y labels.
#
plot(df$Date, df$Global_active_power, type='l', ylab="Global Active Power (kilowatts)",xlab="")

dev.off()