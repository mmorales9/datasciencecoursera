if (!file.exists("household_power_consumption.txt"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "/household_power_consumption.txt")
  
}
#Downloads the household data if the file is not in the current directory

householddata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
#Reads the text file and stores it in the householddata variable

householddata$Date <- as.Date(householddata$Date, format = "%d/%m/%Y")
#Formats all of the observations in the Date column to the standard R date format

HouseholdRange <- householddata[householddata$Date == "2007-02-01",]
#Stores data from rows for 2007-02-01 in HouseholdRange variable

HouseholdRange2 <- householddata[householddata$Date == "2007-02-02",]
#Stores data from rows for 2007-02-02 in HouseholdRange2 variable

HouseholdRange <- rbind(HouseholdRange, HouseholdRange2)
#Binds the rows from HouseholdRange and HouseholdRange2 and stores it in the HouseholdRange variable

GlobalPower <- HouseholdRange$Global_active_power
#Stores all Global_active_power data in GlobalPower variable

GlobalPower <- as.numeric(as.vector(GlobalPower))
#Converts the GlobalPower data into vectors and then into numeric values in order to fit qualifications for histogram

hist(GlobalPower, xlab = "Global Active Power (Kilowatts)", col = "red", main = "Global Active Power")
#Constructs the histogram
