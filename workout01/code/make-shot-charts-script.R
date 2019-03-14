# Title: Make Shot Charts ---------------------------------
# Description ---------------------------------
# Inputs ---------------------------------
# Outputs ---------------------------------


library(ggplot2)
klay_scatterplot <- ggplot(data = thompson) + geom_point(aes(x = x, y = y, color = shot_made_flag))
klay_scatterplot


library(jpeg)
library(grid)
# court image (to be used as background of plot)
court_file <- "/Users/madisontagg/Desktop/workout01/images/nba-court.jpg"

# create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

# shot chart with court background
klay_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
klay_shot_chart + ggsave("/Users/madisontagg/Desktop/workout01/images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)

draymond_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal() 
draymond_shot_chart + ggsave("/Users/madisontagg/Desktop/workout01/images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)

kevin_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal() 
kevin_shot_chart + ggsave("/Users/madisontagg/Desktop/workout01/images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)

andre_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal() 
andre_shot_chart + ggsave("/Users/madisontagg/Desktop/workout01/images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)

steph_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Steph Curry (2016 season)') +
  theme_minimal() 
steph_shot_chart + ggsave("/Users/madisontagg/Desktop/workout01/images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)

#Faced Shot chart
gsw_shot_chart <- ggplot(global_table, aes(x = x, y = y, color = shot_made_flag)) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point() + ylim(-50, 420) + ylim(-50, 420) +
  ggtitle('Shot Chart: Shot Charts (2016 season)') + theme_minimal() + facet_wrap(~name)

gsw_shot_chart + ggsave("/Users/madisontagg/Desktop/workout01/images/gsw-shot-charts.pdf", width = 8, height = 7)

png("/Users/madisontagg/Desktop/workout01/images/gsw-shot-charts.png", width = 800, height = 700)
gsw_shot_chart
dev.off()

