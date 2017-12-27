### Download and unzip PM2.5 Data Set
file <- "PM2.5.zip"
if (!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",file)
}
unzip(file,overwrite=FALSE)

### Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Coal combustion PM2.5 emmissions
Coal <- SCC[grepl("coal",tolower(SCC$EI.Sector))&grepl("combustion",tolower(SCC$SCC.Level.One)),]
CoalUS <- NEI[NEI$SCC %in% Coal$SCC,]
CoalEM <- aggregate(CoalUS$Emissions,by=list(Year=CoalUS$year),FUN=sum)
#Plot 4
png("plot4.png",height=480,width=480)
barplot(height=CoalEM$x,names.arg=CoalEM$Year,col="red")
title(main="US Coal PM2.5 Emissions by year",xlab="Year",ylab="Emissions (tons)")
dev.off()
rm(CoalEM,CoalUS,Coal)