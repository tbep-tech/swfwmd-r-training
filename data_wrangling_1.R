# Data wrangling part 1 lesson script
# SWFWMD R Training

library(tidyverse)

# ---- Import data ----
dat <- read_csv('data/dat.csv')
head(dat)
dim(dat)
names(dat)
str(dat)

# ---- Selecting ----

# select some columns
dplyr_sel1 <- select(dat, Date, Station, Value)
head(dplyr_sel1)

# select everything but Notes
dplyr_sel2 <- select(dat, -Notes)
head(dplyr_sel2)

# ---- Filtering ----

# filter observations with high values
dplyr_high <- filter(dat, Value > 10)
head(dplyr_high)

# filter observations for a specific station
dplyr_sta <- filter(dat, Station == 'A')
head(dplyr_sta)

# combining filters
filt1 <- filter(dat, Value > 5 & Value < 20)
filt2 <- filter(dat, Station == 'A' & Value > 10)
filt3 <- filter(dat, Station == 'A' | Station == 'B')
filt4 <- filter(dat, Station %in% c('A', 'B'))

# ---- Mutating ----

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

# ---- Exercise 4 ----
ex1 <- select(dat, Date, Station, Value)
ex1 <- filter(ex1, Station == 'A')
ex1 <- rename(ex1, date = Date)
head(ex1)

# ---- Piping ----

# not using pipes
bad_ex <- select(dat, Station, Value)
bad_ex2 <- filter(bad_ex, Value > 10)

# with pipes
good_ex <- dat |> 
  select(Station, Value) |>
  filter(Value > 10)

# ---- Exercise 5 ----
ex2 <- dat |> 
  select(Date, Station, Value) |> 
  filter(Station == 'A') |> 
  rename(date = Date)
head(ex2)
