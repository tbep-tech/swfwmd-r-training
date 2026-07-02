# project-relative file paths
data_file <- file.path("data", "dat.csv")
station_file <- file.path("data", "statloc.csv")

library(here)

# project-relative file paths using here
metadat <- here("data", "metadat.csv")
wqdat <- here("data", "wqdat.csv")

metaurl <- paste0(
  "https://edp.swfwmd.state.fl.us/KiWIS/KiWIS?",
  "service=kisters&type=queryServices&request=getStationList",
  "&station_no=*&datasource=0",
  "&returnfields=station_no,station_name,station_latitude,station_longitude,ca_sta",
  "&format=csv&csvdiv=,",
  "&downloadfilename=Requested_Info_",
  "&custattrfilter=station_status:Active;WaterBody_Name:Lake%20Panasoffkee"
)
metaurl

# import the data
metadat <- read.csv(metaurl)
dim(metadat)

# get the stations
stations <- metadat$station_no

# construct the URL with the stations
wqurl <- paste0(
  "https://edp.swfwmd.state.fl.us/",
  "KiWIS/KiWIS?datasource=0",
  "&format=csv&csvdiv=,",
  "&service=kisters&type=queryServices",
  "&request=getWqmSampleValues",
  "&station_no=", paste(stations, collapse = ','),
  "&period=complete",
  "&dateformat=yyyy-MM-dd%20HH:mm:ss"
)

# retrieve the data
wqdat <- read.csv(wqurl)
head(wqdat)
dim(wqdat)

unique(wqdat$station_no)
setdiff(stations, unique(wqdat$station_no))

wlurl1 <- paste0(
  "https://edp.swfwmd.state.fl.us/",
  "KiWIS/KiWIS?datasource=0&service=kisters", 
  "&type=queryServices",
  "&request=getTimeseriesValues", 
  "&ts_path=362/1035944/236/Day.Mean.NAVD88.Published",
  "&returnfields=Timestamp,Value&metadata=TRUE",
  "&md_returnfields=station_no,station_name,ts_unitsymbol",
  "&period=complete",
  "&dateformat=yyyy-MM-dd%20HH:mm:ss", 
  "&timezone=individual",
  "&format=csv&csvdiv=,"
)

wldat1 <- read.csv(wlurl1)
dim(wldat1)
head(wldat1)

wlurl2 <- paste0(
  "https://edp.swfwmd.state.fl.us/",
  "KiWIS/KiWIS?datasource=0&service=kisters", 
  "&type=queryServices",
  "&request=getTimeseriesValues", 
  "&ts_path=1334/23142/236/Day.Mean.NAVD88.Published",
  "&returnfields=Timestamp,Value&metadata=TRUE",
  "&md_returnfields=station_no,station_name,ts_unitsymbol",
  "&period=complete",
  "&dateformat=yyyy-MM-dd%20HH:mm:ss", 
  "&timezone=individual",
  "&format=csv&csvdiv=,"
)

wldat2 <- read.csv(wlurl2)
dim(wldat2)
head(wldat2)

write.csv(metadat, here("data", "metadat.csv"), row.names = F)
write.csv(wqdat, here("data", "wqdat.csv"), row.names = F)
write.csv(wldat1, here("data", "wldat1.csv"), row.names = F)
write.csv(wldat2, here("data", "wldat2.csv"), row.names = F)

# ?read_csv
# help(package = "dplyr")
# ??mutate
