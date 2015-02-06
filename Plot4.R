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
png(filename = "Plot4.png", width = 480, height = 480, bg = "white")

#
# Draw a set of four charts, specifying the layout first.
#
par(mfcol=c(2,2), mar=c(4,4,0.5,0.5), oma=c(1.5,2,1,1))
plot(df$Date, df$Global_active_power, type='l', ylab="Global Active Power (kilowatts)",xlab="")
plot(df$Date, df$Sub_metering_1, type='l', ylab="Energy sub metering",xlab="")
points(df$Date, df$Sub_metering_2, type='l', col="red")
points(df$Date, df$Sub_metering_3, type='l', col="blue")
legend("topright", col=c("black", "red", "blue"), legend=names(df)[grep("Sub.*", names(df))], lty=1)
plot(df$Date, df$Voltage, type='l', ylab="Voltage", xlab="datetime")
plot(df$Date, df$Global_reactive_power, type='h', ylab="Global_reactive_power", xlab="datetime")

dev.off()