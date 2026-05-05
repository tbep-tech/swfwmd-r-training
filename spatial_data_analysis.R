# Spatial data analysis lesson script
# SWFWMD R Training

library(tidyverse)
library(sf)
library(mapview)

# ---- Load data ----
dat <- read_csv('data/dat.csv')
statloc <- read_csv('data/statloc.csv')
bounds <- st_read('data/bounds.shp')

# ---- Explore sf object ----
bounds
methods(class = 'sf')

# ---- Create sf from data frame ----
str(statloc)

sfstatloc <- st_as_sf(statloc, coords = c('Longitude', 'Latitude'), crs = 4326)
sfstatloc

# ---- Exercise 13 ----
alldat <- left_join(dat, statloc, by = 'Station')
alldat <- st_as_sf(alldat, coords = c('Longitude', 'Latitude'), crs = 4326)
alldat
str(alldat)

# check crs
st_crs(alldat)
st_crs(bounds)

# transform CRS
alldatutm <- alldat |> 
  st_transform(crs = '+proj=utm +zone=17 +datum=NAD83 +units=m +no_defs')
st_crs(alldatutm)

# ---- Geospatial analysis ----
plot(alldat$geometry)
plot(bounds$geometry)

# filter data
filt_dat <- alldat |> 
  filter(Station == 'A')
plot(filt_dat$geometry)

# spatial subset
stat_crop <- alldat[bounds, ]
plot(stat_crop$geometry)

# intersection
stat_int <- st_intersection(alldat, bounds)
plot(stat_int$geometry)

# summarize
area_summary <- stat_int |>
  group_by(AreaName) |> 
  summarise(mean_val = mean(Value, na.rm = TRUE)) 
area_summary

# plot summary
ggplot(area_summary, aes(x = AreaName, y = mean_val)) + 
  geom_bar(stat = 'identity')

# ---- Quick mapping ----

# ggplot with sf
ggplot() + 
  geom_sf(data = bounds, aes(fill = AreaName)) + 
  geom_sf(data = stat_int) 

# mapview
mapview(bounds, zcol = 'AreaName') +
  mapview(stat_int)

# ---- Exercise 14 ----
tomap <- alldat |> 
  filter(Station == 'A') |> 
  st_intersection(bounds)

mapview(tomap, zcol = 'Value')
mapview(bounds, zcol = 'AreaName') + mapview(tomap, zcol = 'Value')
