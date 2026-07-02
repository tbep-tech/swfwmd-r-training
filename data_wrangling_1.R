# # install
# install.packages('tidyverse')

# load
library(tidyverse)

library(here)

# import the data
metadat <- read_csv(here('data', 'metadat.csv'))

# see first six rows
head(metadat)

# dimensions
dim(metadat)

# column names
names(metadat)

# structure
str(metadat)

# first, select some columns
dplyr_sel1 <- select(metadat, station_no, station_name, station_latitude, station_longitude)
head(dplyr_sel1)

# select everything but some columns
dplyr_sel2 <- select(metadat, -c(Waterbody_Name:region_district))
head(dplyr_sel2)

# import water quality data
wqdat <- read_csv(here('data', 'wqdat.csv'))

# see first six rows
head(wqdat)

# dimensions
dim(wqdat)

# column names
names(wqdat)

# structure
str(wqdat)

# filter observations with high values
wqdat_temp <- filter(wqdat, parametertype_name == "Temperature, Water")
head(wqdat_temp)
dim(wqdat_temp)

# filter data for one station
wqdat_sta <- filter(wqdat, station_name == "Lake Panasoffkee 7")
head(wqdat_sta)
dim(wqdat_sta)

# all rows with water temperature greater than 25 C
filt1 <- filter(wqdat, parametertype_name == 'Temperature, Water' & value > 25)
head(filt1)

# all rows with water temperature greater than 25 C and less than 30 C
filt2 <- filter(wqdat, parametertype_name == 'Temperature, Water' & value > 25 & value < 30)
head(filt2)

# get rows for Lake Panasoffkee 7 or Lake Panasoffkee 4
filt3 <- filter(wqdat, station_name == "Lake Panasoffkee 7" | station_name == "Lake Panasoffkee 4")
head(filt3)

# another way to get rows that fulfill multiple criteria
filt4 <- filter(wqdat, station_name %in% c("Lake Panasoffkee 7", "Lake Panasoffkee 4"))
head(filt4)

# add a new column
dplyr_mut1 <- mutate(wqdat, dumb_column = 1)
head(dplyr_mut1)

# add a column as Value divided by 100
dplyr_mut2 <- mutate(wqdat, Value_p100 = value / 100)
head(dplyr_mut2)

# add a category column
dplyr_mut3 <- mutate(wqdat, category = ifelse(value < 10, 'low', 'high'))
head(dplyr_mut3)

# check the class
class(wqdat$timestamp)

# check the timezone
attr(wqdat$timestamp, "tzone")

hist(hour(wqdat$timestamp))

# load lubridate
library(lubridate)

# convert to Eastern Time
wqdat <- mutate(wqdat, timestamp = force_tz(timestamp, tzone = "Etc/GMT+5"))

# create new columns for year, month, day, and hour
wqdat_dates <- mutate(wqdat, 
  year = year(timestamp),
  month = month(timestamp),
  day = day(timestamp),
  hour = hour(timestamp)
)
head(wqdat_dates)

# ex1 <- select(wqdat, timestamp, station_name, parametertype_name, value)
# ex1 <- filter(ex1, station_name == "Lake Panasoffkee 8" & `parametertype_name` == "Temperature, Water")
# ex1 <- mutate(ex1, timestamp = force_tz(timestamp, tzone = "Etc/GMT+5"))

# cropdat <- rawdat[1:28]
# savecols <- data.frame(cropdat$Party, cropdat$`Last Inventory Year (2015)`)
# names(savecols) <- c('Party','2015')
# savecols$rank2015 <- rank(-savecols$`2015`)
# top10df <- savecols[savecols$rank2015 <= 10,]
# basedat <- cropdat[cropdat$Party %in% top10df$Party,]

# not using pipes, select a column, filter rows
bad_ex <- select(wqdat, station_name, value)
bad_ex2 <- filter(bad_ex, value > 10)

# with pipes, select a column, filter rows
good_ex <- wqdat |> 
  select(station_name, value) |>
  filter(value > 10)

# ex2 <- wqdat |>
#   select(timestamp, station_name, parametertype_name, value) |>
#   filter(station_name == "Lake Panasoffkee 8" & `parametertype_name` == "Temperature, Water") |>
#   mutate(timestamp = force_tz(timestamp, tzone = "Etc/GMT+5"))
# head(ex2)
