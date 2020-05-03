
#1.Setting up the folder, downloading data and unzipping the file 
#(I) Setting the path to the directory storing the data 
setwd("E:/Coursera/Exploratory Data Analysis/Week 1 Peer Review/")
#(II) Downloading the file
if(!file.exists("./data")){dir.create("./data")
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,destfile="./data/Dataset.zip")
        #(II) Unzip the downloaded file
        unzip(zipfile="./data/Dataset.zip",exdir="./data")}

#2. Reading the data and converting into table
hpc <- read.table("./data/household_power_consumption.txt", skip=1, sep=";")
#3. Labeling the columns appropriately
names(hpc) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
#4. Subsetting the data to account for the selected dates
hpc_subset <- subset(hpc,hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007")


#5. Manipulating the date and time variables provided into approproate Date and POSIXlt format
hpc_subset$Date <- as.Date(hpc_subset$Date, format="%d/%m/%Y")
hpc_subset$Time <- strptime(hpc_subset$Time, format="%H:%M:%S")
hpc_subset[1:1440,"Time"] <- format(hpc_subset[1:1440,"Time"],"2007-02-01 %H:%M:%S")
hpc_subset[1441:2880,"Time"] <- format(hpc_subset[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


#Plot 3
png(file="./data/plot3.png",
    width=480, height=480)
plot(hpc_subset$Time, hpc_subset$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
with(hpc_subset, lines(Time, as.numeric(as.character(Sub_metering_1)), col="black"))
with(hpc_subset, lines(Time, as.numeric(as.character(Sub_metering_2)), col="red"))
with(hpc_subset, lines(Time, as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
dev.off()