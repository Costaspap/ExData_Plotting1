if(!file.exists("household_power_consumption.txt")){
  url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,"data")
  unzip("data")
  file.remove("data")
}

Sys.setlocale("LC_TIME", "English")

data = read.csv("household_power_consumption.txt",sep=";",na.strings="?",skip=66636,nrows=2880,stringsAsFactors=FALSE,
                col.names=c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))

data$date=as.Date(data$date, format="%d/%m/%Y")

data$date = paste(data$date,data$time, sep=" ")

data$date=strptime(data$date,"%Y-%m-%d %H:%M:%S")

data=data[,-2]

png("plot4.png",width=480,height=480)

par(mfrow=c(2,2))

plot(data$date,data$global_active_power,type="l",ylab="Global Active Power",xlab="")

plot(data$date,data$voltage,type="l",ylab="Voltage",xlab="datetime")

plot(data$date,data$sub_metering_1,ylab="Energy sub metering",xlab="",col="black",type="l")

lines(data$date,data$sub_metering_2,col="red")

lines(data$date,data$sub_metering_3,col="blue")

legend("topright",col=c("black", "red", "blue"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1,bty="n")

plot(data$date,data$global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

dev.off()