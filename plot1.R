### File name "plot1.R"
### Data file is "household_power_consumption.txt" 
### This data file needs to be in the working directory
### This script outputs a "PNG" file "plot1.png" to the working directory
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
##
## plot histogram
# set some variables for the plot
titleHistogram <- "Global Active Power"
xAxisLabel <- "Global Active Power (kilowatts)"
yAxisLabel <- "Frequency"
histogramData <- HPC$Global_active_power
colour = "red"
plotHist <- TRUE  # set to FALSE to avoid being plotted
freqYes <- TRUE   # want a frequency plot
PNGwidth <- 480
PNGheight <- 480
PNGfilename <- "plot1.png"
# print to "PNG" file in the working directory
png(filename = PNGfilename, width = PNGwidth, height = PNGheight)
hist(histogramData, freq = freqYes, main = titleHistogram, plot = plotHist,
    xlab = xAxisLabel, ylab = yAxisLabel, col = colour)  
dev.off()    # do not forget to tidy up