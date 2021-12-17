library(tidyverse)
library(cowplot)

summary <- read_csv('summary.csv')%>%
  mutate(R = as.factor(R)) %>%
  mutate(Feed = as.factor(Feed)) %>%
  mutate(rpm = as.factor(rpm))

# Mean
m <- ggplot(data = summary) +
  geom_point(mapping = aes(x = rpm, y = Mean, shape = Feed, color = R))
save_plot("Mean vs speed.pdf",m,
          base_height = 4, base_width = 5)

# Standard deviation
sd <- ggplot(data = summary) +
  geom_point(mapping = aes(x = rpm, y = Std..dev, shape = Feed, color = R))
save_plot("Standard deviation vs speed.pdf",sd,
          base_height = 4, base_width = 5)
# Skewness
sk <- ggplot(data = summary) +
  geom_point(mapping = aes(x = rpm, y = Skewness, shape = Feed, color = R))
save_plot("Skewness vs speed.pdf",sk,
          base_height = 4, base_width = 5)
#Kurtosis
k <-  ggplot(data = summary) +
  geom_point(mapping = aes(x = rpm, y = Kurtosis, shape = Feed, color = R))
save_plot("Kurtosis vs speed.pdf",k,
          base_height = 4, base_width = 5)
# Mean trend
mt <- ggplot(data = summary) +
  geom_point(mapping = aes(x = rpm, y = Mean_trend, shape = Feed, color = R))
save_plot("Mean trend vs speed.pdf",mt,
          base_height = 4, base_width = 5)
# Standard deviation trend
sdt <- ggplot(data = summary) +
  geom_point(mapping = aes(x = rpm, y = Std.dev_trend, shape = Feed, color = R))
save_plot("Standard deviation trend vs speed.pdf",sdt,
          base_height = 4, base_width = 5)
#Scatterplot
mvs <- ggplot(data = summary) +
  geom_point(mapping = aes(x = Mean, y = Std..dev, shape = Feed, color = rpm))
save_plot("mean vs sd.pdf",mvs,
          base_height = 4.5, base_width = 5)
