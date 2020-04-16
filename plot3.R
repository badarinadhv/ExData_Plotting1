## Down load the file from the Course site

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(".data")){dir.create("./data")}
download.file(fileurl,destfile="./data/household_power_consumption.zip") 

## Unzip the downloaded file 

file1<-unzip("./data/household_power_consumption.zip", exdir = "./data") 

data<-read.table(file1,skip=0,sep=";",header = TRUE,stringsAsFactors = FALSE)
dates<-data$Date
dates1<-as.Date(dates, format= "%d/%m/%Y")
data$Date<-dates1
##Subset the data just for the 2 dates 2007-02-01 and 2007-02-02
t1<-as.Date("2007-02-01")
t2<-as.Date("2007-02-02")
data1<-data[data$Date %in% t1:t2, ]
## Time conversion to "POSIXlt" "POSIXt" 
date<-data1$Date
time<-data1$Time
date_time<-paste(date,time)
time<-strptime(date_time,format="%Y-%m-%d %H:%M:%S",tz="")
data1$Time<-time
## PLot3
dev.off()
with(data1,plot(Time,Sub_metering_1,lwd=1,xlab="",ylim=rng,ylab="Energy Sub Metering",type="l",col="black") )
par(new=TRUE)
with(data1,plot(Time,Sub_metering_2,type="l",xlab="",ylab="",ylim=rng,col="red"))
par(new=TRUE)
with(data1,plot(Time,Sub_metering_3,type="l",xlab="",ylab="",ylim=rng,col="blue"))
legend("topright",lty=1,col=c("blue","red","black"),cex=0.75,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,filename = "plot3.png",width = 480, height = 480, units = "px")
dev.off()
