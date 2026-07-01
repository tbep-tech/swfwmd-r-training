library(tidyverse)
library(here)
library(sf)
library(mapview)

wqdat <- read_csv(here('data', 'wqdat.csv'))
str(wqdat)

# a station vector so we don't have to type out all the names
stas <- paste('Lake Panasoffkee', c(7, 1, 8, 4))

# wrangle the data
toplo <- wqdat |> 
  dplyr::filter(station_name %in% stas) |> 
  dplyr::filter(parametertype_name == 'Dissolved Oxygen') |> 
  dplyr::filter(year(timestamp) == 2025) |> 
  mutate(
    date = as.Date(timestamp), 
    station_name = factor(station_name, levels = stas)
  ) |> 
  summarise(
    value = mean(value, na.rm = T), 
    .by = c(date, station_name)
  )

str(toplo)

ggplot(toplo, aes(x = date, y = value)) +
  geom_col()

ggplot(toplo, aes(x = date, y = value, fill = station_name)) +
  geom_col()

ggplot(toplo, aes(x = date, y = value, fill = station_name)) +
  geom_col(position = position_dodge(), color = 'grey')

ggplot(toplo, aes(x = date, y = value, fill = station_name)) + 
  geom_col(position = position_dodge(), color = 'grey') + 
  scale_fill_brewer(palette = 'Greens', direction = -1)

ggplot(toplo, aes(x = date, y = value, fill = station_name)) + 
  geom_col(position = position_dodge(), color = 'grey') + 
  scale_fill_brewer(palette = 'Greens', direction = -1) + 
  theme_bw()

ggplot(toplo, aes(x = date, y = value, fill = station_name)) + 
  geom_col(position = position_dodge(), color = 'grey') + 
  scale_fill_brewer(palette = 'Greens', direction = -1) + 
  theme_bw(base_size = 18) + 
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1), 
    legend.position = 'bottom', 
    panel.grid.minor = element_blank()
  )

ggplot(toplo, aes(x = date, y = value, fill = station_name)) + 
  geom_col(position = position_dodge(), color = 'grey') + 
  scale_fill_brewer(palette = 'Greens', direction = -1) + 
  theme_bw() + 
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1), 
    legend.position = 'bottom', 
    panel.grid.minor = element_blank()
  ) +
  labs(
    x = 'Recorded Date', 
    y = 'Dissolved Oxygen (mg/L)', 
    fill = NULL
  ) 

p <- ggplot(toplo, aes(x = date, y = value, fill = station_name)) + 
  geom_col(position = position_dodge(), color = 'grey') + 
  scale_fill_brewer(palette = 'Greens', direction = -1) + 
  theme_bw() + 
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1), 
    legend.position = 'bottom', 
    panel.grid.minor = element_blank()
  ) +
  labs(
    x = 'Recorded Date', 
    y = 'Dissolved Oxygen (mg/L)', 
    fill = NULL
  ) 

png(here('figs/swfwmd_examples', 'dosummary.png'), height = 3, width = 8, units = 'in', res = 300)
print(p)
dev.off()

methods(class = 'sf')

metadat <- read_csv(here('data', 'metadat.csv')) |> 
  select(station_name, station_longitude, station_latitude, WBID)

sfmetadat <- st_as_sf(metadat, coords = c('station_longitude', 'station_latitude'), crs = 4326)
sfmetadat

sfmetadatutm <- sfmetadat |> 
  st_transform(crs = '+proj=utm +zone=17 +datum=NAD83 +units=m +no_defs')
st_crs(sfmetadatutm)

# use ggplot with sf objects
ggplot() + 
  geom_sf(data = sfmetadat, aes(fill = WBID))

mapview(sfmetadat, zcol = 'WBID')
