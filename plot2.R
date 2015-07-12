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

GP <- HouseholdRows$Global_active_power

DT <- HouseholdRows$DateandTime2

GP <- as.numeric(as.vector(GP))

par(mfrow = c(1, 1))

plot(DT, GP, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")

dev.copy(png, file = "plot2.png")

dev.off()
