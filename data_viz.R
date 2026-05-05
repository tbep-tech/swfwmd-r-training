# Data viz lesson script
# SWFWMD R Training

library(tidyverse)

dat <- read_csv('data/dat.csv')

# ---- Base R graphics ----

# simple plot
plot(dat$Value)

# scatter plot
plot(dat$Date, dat$Value)

# histogram
hist(dat$Value)

# boxplot
boxplot(Value ~ Station, data = dat)

# ---- GGplot2 basics ----

# basic scatter plot
ggplot(dat, aes(x = Date, y = Value)) + 
  geom_point()

# add color by station
ggplot(dat, aes(x = Date, y = Value, color = Station)) + 
  geom_point()

# line plot
ggplot(dat, aes(x = Date, y = Value, color = Station)) + 
  geom_line()

# histogram
ggplot(dat, aes(x = Value)) + 
  geom_histogram()

# boxplot
ggplot(dat, aes(x = Station, y = Value)) + 
  geom_boxplot()

# bar plot
sumdat <- summarize(dat, mean_val = mean(Value, na.rm = TRUE), .by = Station)
ggplot(sumdat, aes(x = Station, y = mean_val)) + 
  geom_bar(stat = 'identity')

# ---- Modifying plot components ----

# labels and titles
ggplot(dat, aes(x = Date, y = Value, color = Station)) + 
  geom_point() +
  labs(x = 'Date', y = 'Value', title = 'Training Data', color = 'Station')

# themes
ggplot(dat, aes(x = Date, y = Value, color = Station)) + 
  geom_point() +
  theme_minimal()

ggplot(dat, aes(x = Date, y = Value, color = Station)) + 
  geom_point() +
  theme_bw()

# facets
ggplot(dat, aes(x = Date, y = Value)) + 
  geom_point() +
  facet_wrap(~Station)

# ---- Saving your plots ----

# save most recent plot
ggsave('myplot.png', width = 8, height = 6)
