library(tidyverse)
library(janitor)

# download the file

url<- download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                    destfile = "./Module 4/Electric_power_consumption.zip")


# unzip the file
unzip(zipfile = "./Module 4/Electric_power_consumption.zip",
      files= "household_power_consumption.txt", 
      exdir = "./Module 4/household_power_consumption")

# read the file
df<- read.table(file= "./Module 4/household_power_consumption/household_power_consumption.txt",
                sep = ";", header = T) %>%
  clean_names() %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y")) %>% 
  filter(between(date, as.Date("2007-02-01"), as.Date("2007-02-02"))) %>%  # filter dates# column names tu lower case
  mutate_at(.vars = c("global_active_power", "global_reactive_power", "voltage", 
                      "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3"),
            .funs = as.numeric) %>% # columns 3 to 9 parse to numeric
  mutate(datetime = paste(as.Date(date), time),
         datetime = as.POSIXct(datetime)) # paste date and time to create a new column


## Plot 1

png("plot1.png", width = 480, height = 480)

hist(x = df$global_active_power, main= "Global Active Power", col = "red", xlab = "Global Active Power (Kilowatts)")

dev.off()