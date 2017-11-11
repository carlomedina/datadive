library(lubridate)
library(dplyr)
library(ggplot2)

path <- "/Volumes/courses/QAC/Projects/etown"
df <- read.csv(paste0(path, "/listings_California.csv"), stringsAsFactors = F)

# by day
numberOfSalesDay <- df %>%
  mutate(Posted.at.est = mdy(Posted.at.est)) %>%
  group_by(Posted.at.est) %>%
  mutate(month = month(Posted.at.est)) %>%
  summarise(count = n())

# by month
numberOfSalesMonth <- df %>%
  mutate(Posted.at.est = mdy(Posted.at.est)) %>%
  mutate(month = month(Posted.at.est),
         year = year(Posted.at.est)) %>%
  group_by(month, year) %>%
  summarise(count = n()) %>%
  arrange(year, month) %>%
  mutate(date = mdy(paste0(month,'/',1,'/',year)))


ggplot(numberOfSalesDay, aes(x=Posted.at.est, y = count)) +
  geom_smooth() +
  geom_line(alpha = 0.2)


ggplot(numberOfSalesMonth, aes(x=date, y = count)) +
  # geom_smooth() +
  geom_line(alpha = 0.2)


ggplot(df, aes(x=Longitude, Latitude)) + 
  geom_point()

length(unique(df$Latitude))

