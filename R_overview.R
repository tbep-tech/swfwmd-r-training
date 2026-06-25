# R overview lesson script
# SWFWMD R Training

# ---- Project-oriented workflow ----

# Start each analysis in an RStudio Project so paths stay relative
getwd()
list.files()

# Build file paths inside the project instead of hard-coding an absolute path
data_file <- file.path("data", "dat.csv")
station_file <- file.path("data", "statloc.csv")

file.exists(data_file)
file.exists(station_file)

# ---- Bringing data into the project ----

library(tidyverse)

dat <- read_csv(data_file)
statloc <- read_csv(station_file)

glimpse(dat)
glimpse(statloc)

# Quick checks before you do real work
names(dat)
summary(dat)
count(statloc)

# ---- Working with inherited scripts ----

# Read scripts top to bottom:
# 1. Which packages are loaded?
# 2. Which files are imported?
# 3. Which objects are created?
# 4. What are the outputs?

# Example: create a compact summary you could hand off to a colleague
dat_summary <- dat %>%
  summarize(
    rows = n(),
    cols = ncol(dat)
  )

dat_summary

# ---- SWFWMD portal example ----

# Example URL pattern for pulling data from the SWFWMD data portal
station_url <- paste0(
  "https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?",
  "service=kisters&type=queryServices&request=getStationList",
  "&station_no=*&datasource=0",
  "&returnfields=station_no,station_name,station_latitude,station_longitude",
  "&format=csv&csvdiv=,"
)

station_url

# Later modules can use portal data directly after the course examples are finalized

# ---- Troubleshooting ----

# Common first checks
head(dat)
dim(dat)
str(dat)

# If something fails, inspect the object before changing the code
unique(names(dat))
