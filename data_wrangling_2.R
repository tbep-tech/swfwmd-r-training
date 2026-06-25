# # install
# install.packages('tidyverse')

library(tidyverse)

# load the training data
dat <- read_csv('data/dat.csv')

# load the station location data
statloc <- read_csv('data/statloc.csv')

# join the two 
joindat <- left_join(dat, statloc, by = 'Station')
head(joindat)

# load the training data
dat <- read_csv('data/dat.csv')

# load the station location data
statloc <- read_csv('data/statloc.csv')

# wrangle before join
joindat <- dat |> 
  select(Date, Station, Value) |> 
  filter(Station == 'A') 

dim(joindat)

# full join
joindat <- joindat |> 
  full_join(statloc, by = 'Station')

dim(joindat)

table1
table2
table3

# Spread across two tibbles
table4a  # cases
table4b  # population

table4a

table4a |>
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

table2

pivot_wider(table2, names_from = 'type', values_from = 'count')

# check dimensions, structure
dim(dat)
str(dat)

# convert dat to long format
longdat <- dat |>
  pivot_longer(-c(Date, Station), names_to = 'Parameter', values_to = 'Value')

# check dimensions, structure
dim(longdat)
str(longdat)

by_sta <- summarize(dat, mean_val = mean(Value), .by = Station)
by_sta

by_sta_yr <- dat |> 
  mutate(Year = lubridate::year(Date)) |> 
  summarize(mean_val = mean(Value), .by = c(Station, Year))
by_sta_yr

more_sums <- summarize(dat, 
    n = n(),
    min_val = min(Value),
    max_val = max(Value),
    mean_val = mean(Value), 
    .by = Station
  )
more_sums

x <- c(1, 2, NA, 4)
mean(x)
mean(x, na.rm = T)

anyNA(x)

sumdat <- longdat |>
  filter(Station == 'A' & Parameter == 'Value') |> 
  mutate(Year = lubridate::year(Date)) |> 
  summarize(
    ave = mean(Value, na.rm = TRUE), 
    .by = Year
  ) |> 
  arrange(-ave)
sumdat
