#HIST 1
g2 = ggplot(l) +
  geom_bar(aes(bins),
           color = "#F5EDE6",
           lwd = .5,
           linetype = 1) +
  scale_x_continuous(name = 'Hours before/after midnight',
                     limits = c(-5,5),
                     breaks = seq(-4,5,.5)) +
  ylab('Number of detections') +
  facet_wrap(~FOLDER) +
  theme(panel.background = element_rect('black'),
        panel.grid = element_blank(),
        axis.text.x = element_text(angle = 90),
        text = element_text(size = 15))

print(g2)

ggsave('g2.jpg',
       g2,
       path = 'C:/Users/G00399072/OneDrive - Atlantic TU/Desktop/nocmig/graphs',
       width = 300,
       height = 180,
       units = 'mm',
       dpi = 600
)

#HIST 2
g4 = ggplot(t) +
  geom_bar(aes(DATE+.5),
           color = "#F5EDE6",
           lwd = .5,
           linetype = 1) +
  scale_x_date(name = 'Date',
               breaks = '1 day') +
  geom_vline(aes(xintercept = as.Date('2023-03-28')), 
             color = 'white', 
             lwd = 1) +
  scale_y_continuous(name='Number of detections',
                     breaks = seq(0,100,10)) +
  theme(panel.background = element_rect('black'),
        panel.grid = element_blank(),
        axis.text.x = element_text(angle = 90),
        text = element_text(size = 15))

print(g4)

ggsave('g4.jpg',
       g4,
       path = 'C:/Users/G00399072/OneDrive - Atlantic TU/Desktop/nocmig/graphs',
       width = 300,
       height = 180,
       units = 'mm',
       dpi = 600
)