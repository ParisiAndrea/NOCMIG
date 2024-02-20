#group detections into bins 
n[, bins := format(as.POSIXct(cut(as.POSIXct(TIME, format = '%H:%M'), 
                                  breaks='10 min')), format = '%H:%M')]

#get the amount of vocalisations for each bin 
e = n %>%
  group_by(FOLDER,FILE,DATE,bins) %>%
  summarise(ssize = n())

#mark as before (BEF) and after (AFT) midnight
l = e %>%
  mutate(sd = case_when(as.ITime(bins) > as.ITime('12:00') ~ 'BEF',
                        TRUE ~ 'AFT')) %>%
  as.data.table()

#convert time bins into decimals
l$bins = sapply(strsplit(l$bins,":"),
                 function(x) {
                   x <- as.numeric(x)
                   x[1]+x[2]/60 #inverse: 24±((61*x)/60)
                 }
)

#get time as before/after midnight
l[sd=='BEF']$bins = -(as.numeric('24.00') - l[sd=='BEF']$bins)

#get an alternative df for plotting
t = l %>% mutate(recorder = substr(FOLDER, 26, 31),
                  sampling_period = substr(FOLDER, 1,24))
head(t)
