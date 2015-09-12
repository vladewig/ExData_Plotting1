### File name "plot4.R"
### Data file is "household_power_consumption.txt" 
### The data file needs to be in the working directory
### This script outputs a file "plot4.png" to the working directory
##
## read in the data file from the working directory
# check the data file exists in the working directory
txtDataFile <- "household_power_consumption.txt"
if (!file.exists(txtDataFile)) 
    stop("File 'household_power_consumption.txt' not in the working directory")
# read data in keeping $Date and $Time as class characer for the present
theColumnClasses <- c(rep("character", 2), rep("numeric", 7))
HPC <- read.csv2(txtDataFile, header = TRUE, dec = ".",
                 na.strings = "?", colClasses = theColumnClasses, 
                 stringsAsFactors = FALSE)
##
## pull out the start and end dates of interest
# set $Date column to Date class to help get the two dates of interest
HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y") 
# set the two dates of interest
FirstDate <- as.Date("01/02/2007", "%d/%m/%Y")
SecondDate <- as.Date("02/02/2007", "%d/%m/%Y")
# get the observations for the two dates of interest from the data frame
HPC <- HPC[which(HPC$Date == FirstDate | HPC$Date == SecondDate), ]
# convert $Date column back to character
HPC$Date <- as.character(HPC$Date)
# build another column $DateTime containing ($Date:$Time)
HPC$DateTime <- paste(HPC$Date, HPC$Time)
##
## plot the four panels
# want 2 x 2 panels in row order
par(mfrow = c(2, 2))
# set some variables used by all the plots
# need x axis data converted to POSIXlt class
xAxisData <- strptime(HPC$DateTime, "%Y-%m-%d %H:%M:%S")
# construct tic points for x axis
xAxisdays <- as.POSIXct(round(range(xAxisData), "days"))
# PNG dimensions
PNGwidth <- 480
PNGheight <- 480
PNGfilename <- "plot4.png"
# set up to send output to "PNG" file in the working directory
png(filename = PNGfilename, width = PNGwidth, height = PNGheight)
# want 2 x 2 panels in row order
par(mfrow = c(2, 2))
#
# plot panel[1,1]
# set variables
xAxisLabel <- ""
yAxisLabel <- "Global Active Power"
yAxisData <- HPC$Global_active_power
# start the plot
plot(xAxisData, yAxisData, type ="l", xaxt = "n", 
     xlab = xAxisLabel, ylab = yAxisLabel)
# finish the plot of the x axis
axis.POSIXct(1, at = seq(xAxisdays[1], xAxisdays[2], by = "day"), 
             format = "%a", las = 0)
#
# plot panel[1,2]
# set variables
xAxisLabel <- "datetime"
yAxisLabel <- "Voltage"
yAxisData <- HPC$Voltage
# start the plot
plot(xAxisData, yAxisData, type ="l", xaxt = "n", 
     xlab = xAxisLabel, ylab = yAxisLabel)
# finish the plot of the x axis
axis.POSIXct(1, at = seq(xAxisdays[1], xAxisdays[2], by = "day"), 
             format = "%a", las = 0)
#
# plot panel[2,1]
# set variables
xAxisLabel <- ""
yAxisLabel <- "Energy sub metering"
yAxisData1 <- HPC$Sub_metering_1
colour1 <- "black"
yAxisData2 <- HPC$Sub_metering_2
colour2 <- "red"
yAxisData3 <- HPC$Sub_metering_3
colour3 <- "blue"
legendColours <- c(colour1, colour2, colour3)
legendNames <- colnames(HPC[7:9])
# begin the plot
plot(xAxisData, yAxisData1, type ="l", xaxt = "n", 
     xlab = xAxisLabel, ylab = yAxisLabel, col = colour1)
## add the next two plots
lines(xAxisData, yAxisData2, col = colour2)
lines(xAxisData, yAxisData3, col = colour3)
# plot x axis tics and legend
axis.POSIXct(1, at = seq(xAxisdays[1], xAxisdays[2], by = "day"), 
             format = "%a", las = 0)
# no box around the legend
legend("topright", lty = 1, bty = "n", 
       col = legendColours, legend = legendNames)
#
# plot panel[2,2]
# set variables
xAxisLabel <- "datetime"
yAxisLabel <- "Global_reactive_power"
yAxisData <- HPC$Global_reactive_power
colour = "black"
# start the plot
plot(xAxisData, yAxisData, type ="l", xaxt = "n",
     xlab = xAxisLabel, ylab = yAxisLabel, col = colour)
# finish the plot of the x axis
axis.POSIXct(1, at = seq(xAxisdays[1], xAxisdays[2], by = "day"), 
             format = "%a", las = 0)
# plotting finished
dev.off()    # do not forget to tidy up