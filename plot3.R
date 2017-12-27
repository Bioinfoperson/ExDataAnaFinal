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

### Baltimore PM2.5 emmissions by type
Baltimore <- subset(NEI,fips==24510)
BaltimoreEM <- aggregate(Baltimore$Emissions,by=list(Year=Baltimore$year,Type=Baltimore$type),FUN=sum)
BaltimoreEM$Year <- factor(BaltimoreEM$Year,labels=c("1999","2002","2005","2008"))
#Plot 3
g <- ggplot(BaltimoreEM, aes(Year,x)) + 
  facet_grid(. ~ Type) +
  geom_bar(fill="red",stat="identity") +
  labs(title="Baltimore Emissions by type",y="Emissions (tons)") +
  theme(
        panel.background=element_rect(color="black",fill="white")
        )
ggsave(g,file="plot3.png",height=4,width=7)
rm(g,BaltimoreEM,Baltimore)