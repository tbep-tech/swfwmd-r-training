library(tidyverse)
library(lubridate)


# Import station metadata - I added a few subsets to narrow down the results --------

station.metadata <- paste('https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?service=kisters&type=queryServices&request=getStationList&station_no=*&datasource=0&returnfields=station_no,station_name,station_latitude,station_longitude,ca_sta&format=csv&csvdiv=,&downloadfilename=Requested_Info_', sep = '') %>% 
  read.csv(header = TRUE, stringsAsFactors = FALSE, fill = TRUE) %>% subset(station_status %in% 'Active' & Waterbody_Name %in% 'Lake Panasoffkee')


# Import Water Quality Data ----------------------------------------------------------
## I modified the URL to import only the water quality results that exist for all stations above

WQ.data <- paste("https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?datasource=0&format=csv&csvdiv=,&service=kisters&type=queryServices&request=getWqmSampleValues&station_no=23113,23144,23152,23167,23169&period=complete&dateformat=yyyy-MM-dd%20HH:mm:ss",sep = '') %>% 
  read.csv(stringsAsFactors = FALSE, header = TRUE, fill = TRUE)

WQ.data2 <- paste("https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?datasource=0&format=csv&csvdiv=,&service=kisters&type=queryServices&request=getWqmSampleValues&station_no=",paste(station.metadata$station_no, collapse = ',',sep = ''),"&period=complete&dateformat=yyyy-MM-dd%20HH:mm:ss",sep = '') %>% 
  read.csv(stringsAsFactors = FALSE, header = TRUE, fill = TRUE)


# Import Water Level Data -------------------------------------------------
##Continuous data, such as WL, Rainfall, and some WQ data are reported in what we call time series data. 
##These data can only be imported one URL at a time. 
##I do have a script that can create loops to import that data, but it might be a little advanced for this course.
##The first dataframe is how the data are imported from the database raw. The second station import is a standard way in how I can prep the data to combine with the rbind function.

#WL data for station number 1035944
WL.data.1035944 <- paste("https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?datasource=0&service=kisters&type=queryServices&request=getTimeseriesValues&ts_path=362/1035944/236/Day.Mean.NAVD88.Published&returnfields=Timestamp,Value&metadata=TRUE&md_returnfields=station_no,station_name,ts_unitsymbol&period=complete&dateformat=yyyy-MM-dd%20HH:mm:ss&timezone=individual&format=csv&csvdiv=,&downloadfilename=Requested_Info_", Sys.Date(), sep = "") %>% 
  read.csv(header = FALSE, fill = TRUE)

#WL data for station number 23142 (revised for combining)
WL.data.23142 <- paste("https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?datasource=0&service=kisters&type=queryServices&request=getTimeseriesValues&ts_path=1334/23142/236/Day.Mean.NAVD88.Published&returnfields=Timestamp,Value&metadata=TRUE&md_returnfields=station_no,station_name,ts_unitsymbol&period=complete&dateformat=yyyy-MM-dd%20HH:mm:ss&timezone=individual&format=csv&csvdiv=,&downloadfilename=Requested_Info_", Sys.Date(), sep = "") %>% 
  read.csv(header = FALSE, fill = TRUE)
WL.data.23142$station_no <- WL.data.23142[1,2]
WL.data.23142$station_name <- WL.data.23142[2,2]
WL.data.23142$unit_symbol <- WL.data.23142[3,2]
WL.data.23142 <- WL.data.23142 %>% slice(6:n())

