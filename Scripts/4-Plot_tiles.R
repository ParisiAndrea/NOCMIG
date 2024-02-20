#TILE 1
g1 = ggplot(l) +
  geom_tile(aes(bins, as.Date(DATE)+.5, fill = ssize),
            #color = "white",
            lwd = 1,
            linetype = 1) +
  scale_fill_gradient(low = '#F5EDE6',
                      high = '#F57200',
                      name = 'Detections each 15-minute bin',
                      breaks = seq(0,100,10)) +
  scale_y_date(date_breaks = '1 day',
               name = 'Date') +
  scale_x_continuous(name = 'Hours before/after midnight',
                     limits = c(-4,5),
                     breaks = seq(-4,5,.5)) +
  facet_wrap(~FOLDER, scales = 'free_y') +
  theme(panel.background = element_rect('black'),
        panel.grid = element_blank(),
        legend.position = 'top',
        axis.text.x = element_text(angle = 90))

print(g1)

ggsave('g1.jpg',
       g1,
       path = './Files/graphs',
       width = 300,
       height = 180,
       units = 'mm',
       dpi = 600
)

#TILE 2
g3 = ggplot(t) +
  geom_tile(aes(bins, as.Date(DATE)+0.5, fill = ssize),
            #color = "white",
            lwd = 1,
            linetype = 1) +
  scale_fill_gradient(low = '#F5EDE6',
                      high = '#F57200',
                      name = 'Detections each 15-minute bin',
                      breaks = seq(0,100,10)) +
  scale_y_date(date_breaks = '1 day',
               name = 'Date') +
  scale_x_continuous(name = 'Hours before/after midnight',
                     limits = c(-4,5),
                     breaks = seq(-4,5,.5)) +
  geom_hline(aes(yintercept = as.Date('2023-03-27')+1), 
             color = 'white') +
  theme(panel.background = element_rect('black'),
        panel.grid = element_blank(),
        legend.position = 'top',
        axis.text.x = element_text(angle = 90))

print(g3)

ggsave('g3.jpg',
       g3,
       path = './Files/graphs',
       width = 300,
       height = 180,
       units = 'mm',
       dpi = 600
)