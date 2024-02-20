sapply(c('data.table', 'dplyr', 'tidyr','viridis',
         'lubridate','suncalc','ggplot2','ggpubr'), 
       require, 
       character.only=T)


setwd('C:/Users/G00399072/OneDrive - Atlantic TU/Desktop/nocmig')

###1

d = fread('./2-rescan/cluster.csv') %>%
  dplyr::select(FOLDER,`IN FILE`,DATE,`TIME`,`TOP1MATCH*`,TOP1DIST,DURATION,Fmin,Fmean,Fmax,`MANUAL ID`) %>%
  rename(FILE = `IN FILE`,
         MATCH = `TOP1MATCH*`,
         DIST = TOP1DIST,
         CLASS = `MANUAL ID`)

head(d)

#filter noise out
d = d[CLASS=='nocmig']

#add latitude and longitude information
d[, lat := as.numeric('54.0')]
d[, lon := as.numeric('-7.3')]

#add id
d[, ID := .I]

#get suntimes dataset
as.data.table(getSunlightTimes(data = d[, date := as.Date(DATE)], 
                               keep = c('nightEnd','night')))

#exclude irrelevant columns
z = d %>% 
  dplyr::select(FOLDER:Fmax,nightEnd,night) %>% 
  arrange(FOLDER,DATE,TIME,MATCH) %>%
  mutate(FOLDER = stringr::str_remove(FOLDER, '\\\\Data2'))

#create new date+time variable 
z[, datetime := as.POSIXct(paste(DATE, paste0(TIME, ':00'), 
                                 sep = ' '),
                           tz = 'UTC')]

#classify night/day based on sunlightimes
z = mutate(z, 
           period = case_when(datetime %within% interval(nightEnd, 
                                                         night) ~ 'day', 
                              TRUE ~ 'night'))

#delete datetime
z = z[,-c('nightEnd','night','datetime')]

head(z)