library(ggplot2)

### Download and unzip PM2.5 Data Set
file <- "PM2.5.zip"
if (!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",file)
}
unzip(file,overwrite=FALSE)

### Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Vehicle Emissions in Baltimore vs. LA
BaltimoreLA <- subset(NEI,fips=="24510"|fips=="06037")
BaltimoreLA$fips <- gsub(x=BaltimoreLA$fips,pattern="24510","Baltimore City")
BaltimoreLA$fips <- gsub(x=BaltimoreLA$fips,pattern="06037","Los Angeles County")
Vehicle <- SCC[grepl("mobile",tolower(SCC$SCC.Level.One))&grepl("vehicle",tolower(SCC$SCC.Level.Two)),]
BaltimoreLA <- BaltimoreLA[BaltimoreLA$SCC %in% Vehicle$SCC,]
BaltimoreLA <- aggregate(BaltimoreLA$Emissions,by=list(Year=BaltimoreLA$year,Area=BaltimoreLA$fips),FUN=sum)
BaltimoreLA$Year <- factor(BaltimoreLA$Year,labels=c("1999","2002","2005","2008"))
#Plot 6
g <- ggplot(BaltimoreLA, aes(Year,x)) + 
  facet_grid(. ~ Area) +
  geom_bar(fill="red",stat="identity") + geom_text(label=as.integer(BaltimoreLA$x),vjust=-0.5,size=2.5) + 
  labs(title="Baltimore and LA Motor Vehicle Emissions",y="Emissions (tons)") +
  theme(
    panel.background=element_rect(color="black",fill="white")
  )
ggsave(g,file="plot6.png",height=4,width=5)