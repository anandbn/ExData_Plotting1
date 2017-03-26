## The below R code snippet assumes the file 'household_power_consumption.txt' is available
## in current working directory for R

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
png("plot3.png",width=480,height = 480)

#Plot the global active power with type set to "l"ine chart and supress plotting X-axis
plot(feb_01_02$Sub_metering_1,type="l",xaxt="n",xlab="",ylab="Energy sub metering")
lines(feb_01_02$Sub_metering_2,col="red")
lines(feb_01_02$Sub_metering_3,col="blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red", "blue"), lty=1, cex=0.8)

# calculate the x co-ordinate for x axis ticks: Ranging from 0 to max of values 
# and divided by 2 so that the ticks are equally spaced out into 3 ticks
xticks <- seq(0,dim(feb_01_02)[1], by=(dim(feb_01_02)[1])/2)

# set the x axis ticks but not the labels 
axis(side=1,at=xticks,labels=FALSE)

# display the 3 labels: Thu, Fri, Sat
# use xticks as the X
# use the lowest of the y range [ fetched from par('usr') ] as the Y
# pos = 1 to display 'below'
# offset=1 pushes the label down by 1 character width 
text(x=xticks,  par("usr")[3], labels = c("Thu","Fri","Sat"), pos = 1,offset=1, xpd = TRUE)

## Close PNG file
dev.off()