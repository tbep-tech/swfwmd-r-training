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
    '[R Overview](R_overview.html)',
    'Break',
    '[Data Wrangling Part 1](data_wrangling_1.html)',
    'Lunch',
    '[Data Wrangling Part 2](data_wrangling_2.html) and [Data Visualization](data_viz.html)',
    'Break',
    '[SWFWMD Examples](swfwmd_examples.html)',
    'Wrap-up'
  ),
  stringsAsFactors = FALSE
)

save(agenda, file = 'data/agenda.RData')
