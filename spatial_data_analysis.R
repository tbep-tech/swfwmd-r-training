# load libraries
library(tidyverse)
library(sf)
library(mapview)

# load the training data
dat <- read_csv('data/dat.csv')

# load the station location data
statloc <- read_csv('data/statloc.csv')

# load the spatial boundary shapefile
bounds <- st_read('data/bounds.shp')

methods(class = 'sf')

bounds <- st_read('data/bounds.shp', quiet = T)
bounds

str(statloc)

sfstatloc <- st_as_sf(statloc, coords = c('Longitude', 'Latitude'), crs = 4326)
sfstatloc

# Join the data
alldat <- left_join(dat, statloc, by = 'Station')

# create spatial data object
alldat <- st_as_sf(alldat, coords = c('Longitude', 'Latitude'), crs = 4326)

# examine the sf object
alldat
str(alldat)

# check crs
st_crs(alldat)

# verify the polygon and point data have the same crs
st_crs(bounds)
st_crs(alldat)

alldatutm <- alldat |> 
  st_transform(crs = '+proj=utm +zone=17 +datum=NAD83 +units=m +no_defs')
st_crs(alldatutm)

plot(alldat)
plot(bounds)

plot(alldat$geometry)
plot(bounds$geometry)

filt_dat <- alldat |> 
  filter(Station == 'A')
plot(filt_dat$geometry)

stat_crop <- alldat[bounds, ]
plot(stat_crop$geometry)
stat_crop

stat_int <- st_intersection(alldat, bounds)
plot(stat_int$geometry)
stat_int

area_summary <- stat_int |>
  group_by(AreaName) |> 
  summarise(
    mean_val = mean(Value, na.rm = TRUE)
  ) 
area_summary

ggplot(area_summary, aes(x = AreaName, y = mean_val)) + 
  geom_bar(stat = 'identity')

# use ggplot with sf objects
ggplot() + 
  geom_sf(data = bounds, aes(fill = AreaName)) + 
  geom_sf(data = stat_int) 

mapview(bounds, zcol = 'AreaName') +
  mapview(stat_int)

# filter and intersect data
tomap <- alldat |> 
  filter(Station == 'A') |> 
  st_intersection(bounds)

# make maps
mapview(tomap, zcol = 'Value')

# join maps
mapview(bounds, zcol = 'AreaName') + mapview(tomap, zcol = 'Value')
