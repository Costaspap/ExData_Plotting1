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

png("plot1.png",width=480,height=480)

hist(data$global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

dev.off()