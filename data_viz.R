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

# ggplot(dat, aes(x = Date, y = Value)) +
#   geom_point() +
#   scale_y_continuous('Value')

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  theme(
    legend.position = 'top',
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = 'lightblue')
  )

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  theme_bw()

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  theme_minimal()

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  theme_classic()

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  theme_bw(base_family = 'serif', base_size = 16)

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  stat_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(colour = drv)) + 
  stat_smooth()

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  stat_smooth(method = 'lm')

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  stat_smooth(method = 'lm') + 
  facet_wrap(~ drv, ncol = 3)

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point() + 
  stat_smooth(method = 'lm') + 
  facet_wrap(~ drv, ncol = 3, scales = 'free')

# ggplot(dat, aes(x = Date, y = Value)) +
#   geom_point() +
#   scale_y_continuous('Value') +
#   theme_minimal() +
#   stat_smooth(method = 'lm') +
#   facet_wrap(~ Gear, ncol = 3)

# ggsave('figure/myfig.jpg', device = 'jpeg', width = 5, height = 4, units = 'in', dpi = 300)

# # save a plot as png file
# png('figure/myfig.png', width = 5, height = 4, units = 'in', res = 300)
# plot
# dev.off()
