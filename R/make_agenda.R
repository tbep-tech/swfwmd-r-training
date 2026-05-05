# Script to create agenda.RData for the index page
# Run this script once to generate the data file

agenda <- data.frame(
  Time = c(
    '8:30 AM - 9:00 AM',
    '9:00 AM - 10:30 AM',
    '10:30 AM - 10:45 AM',
    '10:45 AM - 12:15 PM',
    '12:15 PM - 1:00 PM',
    '1:00 PM - 2:30 PM',
    '2:30 PM - 2:45 PM',
    '2:45 PM - 4:15 PM',
    '4:15 PM - 4:30 PM'
  ),
  Topic = c(
    'Introduction and Setup',
    'R Basics',
    'Break',
    'Data Wrangling Part 1',
    'Lunch',
    'Data Wrangling Part 2 and Data Visualization',
    'Break',
    'Spatial Data Analysis',
    'Wrap-up'
  ),
  stringsAsFactors = FALSE
)

save(agenda, file = 'data/agenda.RData')
