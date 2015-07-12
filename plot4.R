if (!file.exists("household_power_consumption.txt"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "/household_power_consumption.txt")
  
}
#Downloads the household data if the file is not in the current directory


householddata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
#Reads the text file and stores it in the householddata variable

Date <- householddata$Date

Time <- householddata$Time

DateandTime <- cbind(as.character(Date), as.character(Time))

DateandTime1 <- do.call(paste, as.data.frame(DateandTime, stringsAsFactors=FALSE))

DateandTime2 <- strptime(DateandTime1, format = "%d/%m/%Y %H:%M:%S")

HouseholdData2 <- cbind(DateandTime2, householddata)

HouseholdRows1 <- HouseholdData2[format(HouseholdData2$DateandTime2, "%Y-%m-%d") == "2007-02-01",]

HouseholdRows2 <- HouseholdData2[format(HouseholdData2$DateandTime2, "%Y-%m-%d") == "2007-02-02",]

HouseholdRows <- rbind(HouseholdRows1, HouseholdRows2)

DT <- HouseholdRows$DateandTime2

GP <- HouseholdRows$Global_active_power

GP <- as.numeric(as.vector(GP))

Metering1 <- HouseholdRows$Sub_metering_1

Metering2 <- HouseholdRows$Sub_metering_2

Metering3 <- HouseholdRows$Sub_metering_3

par(mfrow = c(2, 2))

plot(DT, GP, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")

with(HouseholdRows,
     plot(DateandTime2, as.numeric(as.vector(Voltage)), xlab = "datetime", ylab = "Voltage", type = "l"))

with(HouseholdRows, 
     plot(DateandTime2, Sub_metering_1, type = "n", yaxt = "n",  xlab = " ", ylab = "Energy sub metering"))
     axis(side = 2, at = seq(0, 30, by = 10))
     lines(DT, Metering1, col = "black")
     lines(DT, Metering2, col = "red")
     lines(DT, Metering3, col = "blue")
     
with(HouseholdRows,
     plot(DateandTime2, as.numeric(as.vector(Global_reactive_power)), xlab = "datetime", ylab = "Global_reactive_power", type = "l"))
     
dev.copy(png, file = "plot4.png", width = 480, height = 480)

dev.off()