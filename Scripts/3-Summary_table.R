#TABLE
###4
e %>%
  #group_by(FOLDER, DATE, bins) %>%
  #summarise(samples = n()) %>%
  arrange(FOLDER,-ssize) %>%
  group_by(FOLDER) %>%
  filter(row_number() %in% c(1,2,3,4,5)) %>%
  fwrite(.,'C:/Users/G00399072/OneDrive - Atlantic TU/Desktop/nocmig/nocmig.csv')