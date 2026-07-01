# load packages
library(tidyverse)
library(here)

# import water quality data
wqdat <- read_csv(here('data', 'wqdat.csv'))

# prepare data to plot (toplo)
toplo <- wqdat |> 
  filter(station_name == 'Lake Panasoffkee 4' & parametertype_name == 'Temperature, Water') |> 
  mutate(
    timestamp = lubridate::with_tz(timestamp, tzone = 'Etc/GMT+5')
  )

# ggplot(data = toplo)

# ggplot(data = toplo) +
#   geom_point()

# ggplot(data = toplo) +
#   geom_point(mapping = aes(x = timestamp, y = value))

# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = toplo) + 
  geom_point(mapping = aes(x = timestamp, y = value))

ggplot(data = toplo, mapping = aes(x = timestamp, y = value)) + 
  geom_point()

ggplot(toplo, aes(x = timestamp, y = value)) + 
  geom_line()

ggplot(toplo, aes(x = timestamp, y = value)) + 
  geom_count()

ggplot(toplo, aes(x = timestamp, y = value)) + 
  geom_density2d()

# ggplot(toplo, aes(x = timestamp, y = value)) +
#   geom_linerange()

# ?geom_linerange

# ?geom_point

ggplot(toplo, aes(x = timestamp, y = value, colour = timestamp)) + 
  geom_point()

ggplot(toplo, aes(x = timestamp, y = value, size = value)) + 
  geom_point()

ggplot(toplo, aes(x = timestamp, y = value, shape = am(timestamp))) + 
  geom_point()

ggplot(toplo, aes(x = timestamp, y = value)) + 
  geom_point(colour = 'red')

# toplo <- wqdat |>
#   filter(station_name == "Lake Panasoffkee 8" & parametertype_name == "Dissolved Oxygen")
# 
# ggplot(toplo, aes(x = timestamp, y = value)) +
#   geom_point() +
#   labs(
#     x = "Date",
#     y = "mg/L",
#     title = "Dissolved oxygen at station Lake Panasoffkee 8"
#   )

toplo <- toplo <- wqdat |> 
  filter(station_name == "Lake Panasoffkee 8" & parametertype_name == "Dissolved Oxygen") |> 
  mutate(
    sample_time = am(timestamp), 
    sample_time = ifelse(sample_time, 'AM', 'PM')
  )

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  theme(
    legend.position = 'top',
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = 'lightblue')
  )

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  theme_bw()

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  theme_minimal()

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  theme_classic()

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  theme_bw(base_family = 'serif', base_size = 16)

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  stat_smooth()

ggplot(toplo, aes(x = timestamp, y = value)) + 
  geom_point(aes(colour = sample_time)) + 
  stat_smooth()

ggplot(toplo, aes(x = timestamp, y = value, color = sample_time)) + 
  geom_point() + 
  stat_smooth(method = 'lm')

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  stat_smooth(method = 'lm') + 
  facet_wrap(~ sample_time, ncol = 2)

ggplot(toplo, aes(x = timestamp, y = value, colour = sample_time)) + 
  geom_point() + 
  stat_smooth(method = 'lm') + 
  facet_wrap(~ sample_time, ncol = 2, scales = 'free')

# ggplot(toplo, aes(x = timestamp, y = value)) +
#   geom_point() +
#   theme_minimal() +
#   stat_smooth(method = "lm") +
#   facet_wrap(~ sample_time, ncol = 2) +
#   labs(
#     x = NULL,
#     y = "mg/L",
#     title = "Lake Panasoffkee 8",
#     subtitle = "Dissolved oxygen over time, grouped by sample time",
#     caption = "Source: SWFWMD Environmental Data Portal"
#   )

# ggsave('figure/myfig.jpg', device = 'jpeg', width = 5, height = 4, units = 'in', dpi = 300)

# # save a plot as png file
# png('figure/myfig.png', width = 5, height = 4, units = 'in', res = 300)
# plot
# dev.off()
