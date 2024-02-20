n = z[period == 'night']

head(n)

n[, bins := format(as.POSIXct(cut(as.POSIXct(TIME, format = '%H:%M'), 
                                  breaks='10 min')), format = '%H:%M')]


e = n %>%
  group_by(FOLDER,FILE,DATE,bins) %>%
  summarise(ssize = n())

ex = e %>%
  mutate(sd = case_when(as.ITime(bins) > as.ITime('12:00') ~ 'BEF',
                        TRUE ~ 'AFT')) %>%
  as.data.table()

ex$bins = sapply(strsplit(ex$bins,":"),
                 function(x) {
                   x <- as.numeric(x)
                   x[1]+x[2]/60
                 }
)

ex[sd=='BEF']$bins = -(as.numeric('24.00') - ex[sd=='BEF']$bins)

t = ex %>% mutate(recorder = substr(FOLDER, 26, 31),
                  sampling_period = substr(FOLDER, 1,24))
head(t)
