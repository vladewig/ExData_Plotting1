### File name "plot3.R"
### Data file is "household_power_consumption.txt" 
### This data file needs to be in the working directory
### This script outputs a "PNG" file "plot3.png" to the working directory
##
## read in data file from the working directory
# check the data file exists in the working directory
txtDataFile <- "household_power_consumption.txt"
if (!file.exists(txtDataFile)) 
    stop("File 'household_power_consumption.txt' not in the working directory")
# read data in keeping $Date and $Time as class character for the present
theColumnClasses <- c(rep("character", 2), rep("numeric", 7))
HPC <- read.csv2(txtDataFile, header = TRUE, dec = ".",
                 na.strings = "?", colClasses = theColumnClasses, 
                 stringsAsFactors = FALSE)
##
## pull out the start and end dates of interest from the data frame
# set $Date column to class Date for comparison with the two dates of interest
HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y") 
# set the two dates of interest
FirstDate <- as.Date("01/02/2007", "%d/%m/%Y")
SecondDate <- as.Date("02/02/2007", "%d/%m/%Y")
# get the observations for the two dates of interest from the data frame
HPC <- HPC[which(HPC$Date == FirstDate | HPC$Date == SecondDate), ]
# convert $Date column back to character
HPC$Date <- as.character(HPC$Date)
# build another column called $DateTime containing ($Date:$Time)
HPC$DateTime <- paste(HPC$Date, HPC$Time)
##
## plot $sub_metering_1, _2 and _3 as a function of $DateTime
# set some variables for the plot
xAxisLabel <- ""
yAxisLabel <- "Energy sub metering"
xAxisData <- strptime(HPC$DateTime, "%Y-%m-%d %H:%M:%S")
yAxisData1 <- HPC$Sub_metering_1
colour1 <- "black"
yAxisData2 <- HPC$Sub_metering_2
colour2 <- "red"
yAxisData3 <- HPC$Sub_metering_3
colour3 <- "blue"
legendColours <- c(colour1, colour2, colour3)
legendNames <- colnames(HPC[7:9])
# PNG variables
PNGwidth <- 480
PNGheight <- 480
PNGfilename <- "plot3.png"
# set up to send the plot to the "PNG" file in the working directory
png(filename = PNGfilename, width = PNGwidth, height = PNGheight)
# begin the plot
plot(xAxisData, yAxisData1, type ="l", xaxt = "n", 
     xlab = xAxisLabel, ylab = yAxisLabel, col = colour1)
# add the next two plots _2 and _3
lines(xAxisData, yAxisData2, col = colour2)
lines(xAxisData, yAxisData3, col = colour3)
# construct tic points for x axis
xAxisdays <- as.POSIXct(round(range(xAxisData), "days"))
# finish off plot - plot the x axis and legend
axis.POSIXct(1, at = seq(xAxisdays[1], xAxisdays[2], by = "day"), 
             format = "%a", las = 0)
legend("topright", lty = 1, col = legendColours, legend = legendNames)
dev.off()    # do not forget to tidy up