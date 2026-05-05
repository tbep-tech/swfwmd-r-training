# Data wrangling part 2 lesson script
# SWFWMD R Training

library(tidyverse)

# ---- Combining data ----
dat <- read_csv('data/dat.csv')
statloc <- read_csv('data/statloc.csv')

# join the two datasets
joindat <- left_join(dat, statloc, by = 'Station')
head(joindat)

# ---- Exercise 6 ----
joindat <- dat |> 
  select(Date, Station, Value) |> 
  filter(Station == 'A') 

dim(joindat)

joindat <- joindat |> 
  full_join(statloc, by = 'Station')

dim(joindat)

# ---- Tidy data ----
table1
table2
table3
table4a
table4b

# pivot_longer
table4a |>
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

# pivot_wider
pivot_wider(table2, names_from = 'type', values_from = 'count')

# ---- Exercise 7 ----
dim(dat)
str(dat)

longdat <- dat |>
  pivot_longer(-c(Date, Station), names_to = 'Parameter', values_to = 'Value')

dim(longdat)
str(longdat)

# ---- Summarize ----
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

# handling NAs
x <- c(1, 2, NA, 4)
mean(x)
mean(x, na.rm = T)
anyNA(x)

# ---- Exercise 8 ----
sumdat <- longdat |>
  filter(Station == 'A' & Parameter == 'Value') |> 
  mutate(Year = lubridate::year(Date)) |> 
  summarize(
    ave = mean(Value, na.rm = TRUE), 
    .by = Year
  ) |> 
  arrange(-ave)
sumdat
