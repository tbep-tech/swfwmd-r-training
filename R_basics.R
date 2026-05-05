# R basics lesson script
# SWFWMD R Training

# ---- Goals and Motivation ----

# R is a language for statistical computing and general purpose programming.
# Let's explore some basic features.

# ---- RStudio ----

# RStudio is the IDE we use for R.
# Key panes: Console, Source, Environment, Files/Plots/Help

# ---- R language fundamentals ----

# R as a calculator
1 + 1
2 * 3
10 / 2
2 ^ 4

# Assignment
x <- 5
y <- 10
x + y

# Functions
sqrt(16)
abs(-5)
log(100)

# ---- Data structures in R ----

# Vectors
nums <- c(1, 2, 3, 4, 5)
chars <- c('a', 'b', 'c')
logs <- c(TRUE, FALSE, TRUE)

# Data frames
df <- data.frame(
  x = c(1, 2, 3),
  y = c('a', 'b', 'c'),
  stringsAsFactors = FALSE
)
df

# ---- Getting your data into R ----

# Load the tidyverse
library(tidyverse)

# Import a CSV file
dat <- read_csv('data/dat.csv')

# Inspect the data
head(dat)
dim(dat)
names(dat)
str(dat)
summary(dat)
