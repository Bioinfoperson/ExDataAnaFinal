### Download and unzip PM2.5 Data Set
file <- "PM2.5.zip"
if (!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",file)
}
unzip(file,overwrite=FALSE)

### Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Baltimore Motor Vehicle PM2.5 emmisions by year
Baltimore <- subset(NEI,fips==24510)
Vehicle <- SCC[grepl("mobile",tolower(SCC$SCC.Level.One))&grepl("vehicle",tolower(SCC$SCC.Level.Two)),]
BaltimoreVehicle <- Baltimore[Baltimore$SCC %in% Vehicle$SCC,]
BaltimoreVehicle <- aggregate(BaltimoreVehicle$Emissions,by=list(Year=BaltimoreVehicle$year),FUN=sum)
#Plot 5
png("plot5.png",height=480,width=480)
barplot(height=BaltimoreVehicle$x,names.arg=BaltimoreVehicle$Year,col="red")
title(main="Baltimore Motor Vehicle PM2.5 Emissions by year",xlab="Year",ylab="Emissions (tons)")
dev.off()
rm(Baltimore,Vehicle,BaltimoreVehicle)