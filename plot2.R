### Download and unzip PM2.5 Data Set
file <- "PM2.5.zip"
if (!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",file)
}
unzip(file,overwrite=FALSE)

### Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Baltimore PM2.5 emmissions over years
Baltimore <- subset(NEI,fips==24510)
BaltimoreEM <- aggregate(Baltimore$Emissions,by=list(Year=Baltimore$year),FUN=sum)
BaltimoreEM <- factor(c(rep(BaltimoreEM[1,1],BaltimoreEM[1,2]),rep(BaltimoreEM[2,1],BaltimoreEM[2,2]),
                    rep(BaltimoreEM[3,1],BaltimoreEM[3,2]),rep(BaltimoreEM[4,1],BaltimoreEM[4,2])),
                  labels=c("1999","2002","2005","2008"))

#Plot 2
png("plot2.png",height=480,width=480)
plot(BaltimoreEM,type="h",col="red",ylab="Emissions (tons)",xlab="Year",main="Baltimore Total PM2.5 Emissions by year")
dev.off()
rm(BaltimoreEM,Baltimore)