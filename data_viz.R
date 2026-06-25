library(tidyverse) # for the mpg dataset
data(mpg)
plot(hwy ~ displ, data = mpg)

plot(mpg$displ, mpg$hwy)

# ?plot

plot(hwy ~ displ, data = mpg, main = 'Highway mileage by engine size', 
     xlab = 'engine size (l)', ylab = 'highway (mpg)')

# ?par

plot(hwy ~ displ, data = mpg, main = 'Highway mileage by engine size', 
     xlab = 'engine size (l)', ylab = 'highway (mpg)', 
     col = 'blue', pch = 18, cex = 0.75, family = 'serif')

par(col = 'blue', pch = 18, cex = 0.75, family = 'serif')
plot(hwy ~ displ, data = mpg, main = 'Highway mileage by engine size', 
     xlab = 'engine size (l)', ylab = 'highway (mpg)')

hist(mpg$hwy)

hist(mpg$hwy, breaks = 20)

# # load tidyverse
# library(tidyverse)
# 
# # load the fish data
# dat <- read_csv('data/dat.csv')
# 
# # time series plot
# plot(Value ~ Date, data = dat)
# 
# # time series plot with title
# plot(Value ~ Date, data = dat, main = 'Value catch for all stations over time')

# ggplot(data = mpg)

# ggplot(data = mpg) +
#   geom_point()

# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy))

# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_line()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_count()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_density2d()

# ggplot(mpg, aes(x = displ, y = hwy)) +
#   geom_linerange()

# ?geom_linerange

# ?geom_point

ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, size = displ)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, shape = drv)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
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
