## Set the custom date and time formats as 'myDate' and 'myTime' classes

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

setClass('myTime')
setAs("character","myTime", function(from) strptime(from, format="%H:%M:%s") )

## Read the data:
##   - ? is a NA in the file
##   - Pass in the classes so that they are read as the respective types

mydata <- read.table(file="household_power_consumption.txt",colClasses = c("myDate","myTime","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),header=TRUE,sep=";",na.strings = "?")

## subset to Feb 01 and 02 of 2007
feb_01_02 <- subset(mydata,Date=="2007-02-01"|Date=="2007-02-02")

## Set the device to PNG
png("plot1.png",width=480,height = 480)

## plot the histogram 
hist(feb_01_02$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

## Close PNG file
dev.off()