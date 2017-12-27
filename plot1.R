### Download and unzip PM2.5 Data Set
file <- "PM2.5.zip"
if (!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",file)
}
unzip(file,overwrite=FALSE)

### Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Total PM2.5 emmissions over years
totalEM <- aggregate(NEI$Emissions,by=list(Year=NEI$year),FUN=sum)
totalEM <- factor(c(rep(totalEM[1,1],totalEM[1,2]),rep(totalEM[2,1],totalEM[2,2]),
         rep(totalEM[3,1],totalEM[3,2]),rep(totalEM[4,1],totalEM[4,2])),
       labels=c("1999","2002","2005","2008"))

#Plot 1
png("plot1.png",height=480,width=480)
plot(totalEM,type="h",col="red",ylab="Emissions (tons)",xlab="Year",main="US Total PM2.5 Emissions by year")
dev.off()
rm(totalEM)