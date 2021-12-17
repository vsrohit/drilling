library(ggplot2)
library(dplyr)
library(cowplot)
# Have a scatter plot with x - speed, y - stat, color - feed
finalresult <- final_cs_combined %>%
  mutate(Feed = as.factor(Feed))

# Mean
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Mean, color = Feed))

# Standard deviation
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Std..dev, color = Feed))

# Skewness
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Skewness, color = Feed))

#Kurtosis
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Kurtosis, color = Feed))

# Mean trend
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Mean_trend, color = Feed))

# Standard deviation trend
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Std.dev_trend, color = Feed))

# Entry mean trend
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = mean_trend_entry, color = Feed))

#Entry std dev trend
ggplot(data = finalresult) +
  geom_point(mapping = aes(x = rpm, y = Std.dev_trend_entry, color = Feed))


