# # install
# install.packages('tidyverse')

library(tidyverse)

library(here)

# load the metadata
metadat <- read_csv(here("data", "metadat.csv"))

# load the water quality data
wqdat <- read_csv(here("data", "wqdat.csv"))

# select station name, lat, lon
metadat <- metadat |> 
  select(station_name, station_latitude, station_longitude)

# format time zone
wqdat <- wqdat |> 
  mutate(timestamp = force_tz(timestamp, tzone = "Etc/GMT+5"))

# join the two 
joindat <- left_join(wqdat, metadat, by = 'station_name')
dim(joindat)
head(joindat)

# wrangle before join
joindat <- wqdat |> 
  select(station_name, timestamp, parametertype_name, value) |> 
  filter(station_name == "Lake Panasoffkee 8" & parametertype_name == "Temperature, Water")

dim(joindat)

# full join
joindat <- joindat |> 
  full_join(metadat, by = 'station_name')

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
dim(wqdat)
str(wqdat)

# convert dat to wide format
widedat <- wqdat |>
  select(-unit_symbol, -parametertype_shortname) |>
  mutate(timestamp = as.Date(timestamp)) |> 
  pivot_wider(names_from = parametertype_name, values_from = value, values_fn = mean)

# check dimensions, structure
dim(widedat)
str(widedat)

by_sta <- summarize(wqdat, mean_val = mean(value, na.rm = T), .by = c(station_name, parametertype_name))
by_sta

by_sta_yr <- wqdat |> 
  mutate(Year = lubridate::year(timestamp)) |> 
  summarize(mean_val = mean(value, na.rm = TRUE), .by = c(station_name, parametertype_name, Year))
by_sta_yr

more_sums <- summarize(wqdat, 
    n = n(),
    min_val = min(value),
    max_val = max(value),
    mean_val = mean(value), 
    .by = c(station_name, parametertype_name)
  )
more_sums

sumdat <- wqdat |>
  filter(station_name == 'Lake Panasoffkee 4' & parametertype_name == 'Temperature, Water') |> 
  mutate(Year = lubridate::year(timestamp)) |> 
  summarize(
    ave = mean(value, na.rm = TRUE), 
    .by = Year
  ) |> 
  arrange(-ave)
sumdat
