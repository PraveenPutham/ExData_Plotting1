# download the file 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "exdata_data_household_power_comsumption.zip")

# unzip to the same location
unzip("./exdata_data_household_power_comsumption.zip")

# file name unzipped is household_power_consumption.txt

# read the file
household_data <- read.table("household_power_consumption.txt", header =TRUE, sep=";", stringsAsFactors = FALSE, dec=".")

# head(household_data) --- Verify if the 9 variable data exist
# head(household_data$Date) --- Verify one of them

# only be using data from the dates 2007-02-01 and 2007-02-02
household_part_data <- household_data[household_data$Date %in% c("1/2/2007","2/2/2007") ,]

#  head(household_part_data$Date)
#  head(household_part_data$Time)

# global acitve power, submetering, global reactive power and voltage
datetime <- strptime(paste(household_part_data$Date, household_part_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
global_active_power <- as.numeric(household_part_data$Global_active_power)
subMeter1 <- as.numeric(household_part_data$Sub_metering_1)
subMeter2 <- as.numeric(household_part_data$Sub_metering_2)
subMeter3 <- as.numeric(household_part_data$Sub_metering_3)
global_reactive_power <- as.numeric(household_part_data$Global_reactive_power)
voltage <- as.numeric(household_part_data$Voltage)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, subMeter1, type="l", main="", xlab="", ylab="Energy sub metering")
lines(datetime, subMeter2, type="l", col="red")
lines(datetime, subMeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")
plot(datetime, global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()


