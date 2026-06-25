# # install
# install.packages('tidyverse')

# load
library(tidyverse)

# import the data
dat <- read_csv('data/dat.csv')

# see first six rows
head(dat)

# dimensions
dim(dat)

# column names
names(dat)

# structure
str(dat)

# first, select some columns
dplyr_sel1 <- select(dat, Date, Station, Value)
head(dplyr_sel1)

# select everything but a column
dplyr_sel2 <- select(dat, -Value)
head(dplyr_sel2)

# filter observations with high values
dplyr_high <- filter(dat, Value > 10)
head(dplyr_high)

# filter observations for a specific station
dplyr_sta <- filter(dat, Station == 'A')
head(dplyr_sta)

# get rows with values between 5 and 20
filt1 <- filter(dat, Value > 5 & Value < 20)
head(filt1)

# get rows from station A with values > 10
filt2 <- filter(dat, Station == 'A' & Value > 10)
head(filt2)

# get rows from station A or B
filt3 <- filter(dat, Station == 'A' | Station == 'B')
head(filt3)

# get rows from station A or B using different syntax
filt4 <- filter(dat, Station %in% c('A', 'B'))
head(filt4)

# add a new column
dplyr_mut1 <- mutate(dat, dumb_column = 1)
head(dplyr_mut1)

# add a column as Value divided by 100
dplyr_mut2 <- mutate(dat, Value_p100 = Value / 100)
head(dplyr_mut2)

# add a category column
dplyr_mut3 <- mutate(dat, category = ifelse(Value < 10, 'low', 'high'))
head(dplyr_mut3)

# arrange by value
dplyr_arr <- arrange(dat, Value)
head(dplyr_arr)

# rename a column
dplyr_rnm <- rename(dat, date = Date)
head(dplyr_rnm)

# ex1 <- select(dat, Date, Station, Value)
# ex1 <- filter(ex1, Station == 'A')
# ex1 <- rename(ex1, date = Date)
# head(ex1)

# cropdat <- rawdat[1:28]
# savecols <- data.frame(cropdat$Party, cropdat$`Last Inventory Year (2015)`)
# names(savecols) <- c('Party','2015')
# savecols$rank2015 <- rank(-savecols$`2015`)
# top10df <- savecols[savecols$rank2015 <= 10,]
# basedat <- cropdat[cropdat$Party %in% top10df$Party,]

# not using pipes, select a column, filter rows
bad_ex <- select(dat, Station, Value)
bad_ex2 <- filter(bad_ex, Value > 10)

# with pipes, select a column, filter rows
good_ex <- dat |> 
  select(Station, Value) |>
  filter(Value > 10)

# ex2 <- dat |>
#   select(Date, Station, Value) |>
#   filter(Station == 'A') |>
#   rename(date = Date)
# head(ex2)
