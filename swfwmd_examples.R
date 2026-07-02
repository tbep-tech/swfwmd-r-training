library(tidyverse)
library(here)
library(sf)
library(mapview)
library(ggspatial)

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
  theme_bw() + 
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

wldat1 <- read_csv(here('data', 'wldat1.csv')) |>
  slice(5:n()) |>
  rename(
    date = X.station_no,
    levelft = X1035944
  ) |>
  mutate(
    date = as.Date(date),
    levelft = as.numeric(levelft)
  )

wldat2 <- read_csv(here('data', 'wldat2.csv')) |>
  slice(5:n()) |>
  rename(
    date = X.station_no,
    levelft = X23142
  ) |>
  mutate(
    date = as.Date(date),
    levelft = as.numeric(levelft)
  )

str(wldat1)
str(wldat2)

toplo <- inner_join(wldat1, wldat2, by = 'date', suffix = c('_1035944', '_23142')) |>
  dplyr::filter(date >= as.Date('2026-06-01'))
head(toplo)

toplo <- toplo |> 
  pivot_longer(-date)
head(toplo) 

toplo <- toplo |>
  separate(name, c('var', 'station')) |>
  mutate(
    station = paste('Station', station)
  )

str(toplo)

toplopts <- toplo |>
  filter(date == max(date))

toplopts

ggplot(toplo, aes(x = date, y = value, color = station)) +
  geom_line()

ggplot(toplo, aes(x = date, y = value, color = station)) +
  geom_line() +
  geom_label(data = toplopts, aes(label = value), hjust = "inward", vjust = "inward", show.legend = F)

ggplot(toplo, aes(x = date, y = value, color = station)) +
  geom_line() +
  geom_label(data = toplopts, aes(label = value), hjust = "inward", vjust = "inward", show.legend = F) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'bottom',
    panel.grid.minor = element_blank()
  )

ggplot(toplo, aes(x = date, y = value, color = station)) +
  geom_line() +
  geom_label(data = toplopts, aes(label = value), hjust = "inward", vjust = "inward", show.legend = F) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'bottom',
    panel.grid.minor = element_blank()
  ) +
  guides(color = guide_legend(nrow = 2, byrow = TRUE))

ggplot(toplo, aes(x = date, y = value, color = station)) +
  geom_line() +
  geom_label(data = toplopts, aes(label = value), hjust = "inward", vjust = "inward", show.legend = F) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'bottom',
    panel.grid.minor = element_blank()
  ) +
  guides(color = guide_legend(nrow = 2, byrow = TRUE)) +
  labs(
    x = 'Recorded Date',
    y = 'Water Level, NAVD88 (ft)',
    color = NULL
  )

p <- ggplot(toplo, aes(x = date, y = value, color = station)) +
  geom_line() +
  geom_label(data = toplopts, aes(label = value), hjust = "inward", vjust = "inward", show.legend = F) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'bottom',
    panel.grid.minor = element_blank()
  ) +
  guides(color = guide_legend(nrow = 2, byrow = TRUE)) +
  labs(
    x = 'Recorded Date',
    y = 'Water Level, NAVD88 (ft)',
    color = NULL
  )

png(here('figs/swfwmd_examples', 'tsplot.png'), height = 3.5, width = 8, units = 'in', res = 300)
print(p)
dev.off()

methods(class = 'sf')

metadat <- read_csv(here('data', 'metadat.csv')) |> 
  select(station_name, station_longitude, station_latitude)

sfmetadat <- st_as_sf(metadat, coords = c('station_longitude', 'station_latitude'), crs = 4326)
sfmetadat

sfmetadatutm <- sfmetadat |> 
  st_transform(crs = '+proj=utm +zone=17 +datum=NAD83 +units=m +no_defs')
st_crs(sfmetadatutm)

# use ggplot with sf objects
ggplot() +
  geom_sf(data = sfmetadat)

meando <- wqdat |> 
  dplyr::filter(parametertype_name == 'Dissolved Oxygen') |> 
  dplyr::filter(month(timestamp) == 6) |>
  summarise(
    value = mean(value, na.rm = T), 
    .by = c(station_name)
  )
meando

tomap <- inner_join(sfmetadat, meando, by = 'station_name')
tomap

ggplot() +
  geom_sf(data = tomap, aes(color = value), size = 5)

ggplot() +
  annotation_map_tile(zoomin = 0) +
  geom_sf(data = tomap, aes(color = value), size = 5)

ggplot() +
  annotation_map_tile(zoomin = 0) +
  geom_sf(data = tomap, aes(color = value), size = 5) +
  annotation_scale(location = 'bl') +
  annotation_north_arrow(location = 'tr', style = north_arrow_fancy_orienteering())

ggplot() +
  annotation_map_tile(zoomin = 0) +
  geom_sf(data = tomap, aes(color = value), size = 5) +
  annotation_scale(location = 'bl') +
  annotation_north_arrow(location = 'tr', style = north_arrow_fancy_orienteering()) +
  theme(
    legend.position = 'bottom'
  ) + 
  labs(
    title = 'Lake Panasoffkee June average Dissolved Oxygen',
    subtitle = 'Southwest Florida Water Management District',
    color = 'mg/L',
    caption = 'Source: SWFWMD Environmental Data Portal'
  )

mapview(tomap, zcol = 'value')

mapview(tomap, zcol = 'value', col.regions = colorRampPalette(c('#132B43', '#56B1F7')), legend = TRUE, layer.name = 'Dissolved Oxygen (mg/L)')

m <- mapview(tomap, zcol = 'value', col.regions = colorRampPalette(c('#132B43', '#56B1F7')), legend = TRUE, layer.name = 'Dissolved Oxygen (mg/L)')
mapshot(m, url = here('figs/swfwmd_examples', 'sfmetadat.html'), selfcontained = TRUE)
