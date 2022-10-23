#rm(list=ls())

library(ggplot2)
library(dplyr)
library(vcd)

#library(dplyr)

#
ford <- read.csv("C:/Users/sophi/OneDrive/Documents/LPNU/???????????????????????? ??????????/lab4/ford.csv", header = TRUE, sep = ",")
head(ford)
df <- ford

# boxplot 
df %>%
  ggplot(aes(x = price, y = transmission)) +
  geom_bar(aes(fill = transmission), position = "dodge", size=0.5, stat="identity", color="black") +
  scale_fill_brewer(palette = 'PuBu') +
  theme_bw()

# pie chart
df %>%
  group_by(transmission) %>%
  summarise(price = round(mean(price))) %>%
  ggplot(aes(x = "", y = price, fill=transmission)) +
  geom_bar(stat="identity", color="white", lwd=1) +
  geom_label(aes(label = price), position= position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = 'PuBu') +
  coord_polar(theta = "y") +
  theme_void()

# donut
df %>%
  group_by(transmission) %>%
  summarise(price = round(mean(price))) %>%
  mutate(size=4.5) %>%
  ggplot(aes(x = size, y = price, fill=transmission)) +
  geom_col(color="white", lwd=1) +
  geom_label(aes(label = price),position= position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = 'PuBu') +
  coord_polar(theta = "y") + xlim(c(3, 5)) +
  theme_void()

# lollipop
df %>%
  mutate(transmission = paste(transmission, fuelType)) %>%
  group_by(transmission) %>%
  summarise(price=round(mean(price))) %>%
  arrange(price) %>%
  mutate(order = seq_len(length(transmission))) %>%
  ggplot(aes(x = reorder(transmission, order), y = price)) +
  geom_segment(aes(xend=transmission, y=0, yend=price),color="darkslateblue",lwd=0.7) + 
  geom_point(color="darkslateblue", size=5, shape=19) +
  geom_label(aes(x = transmission, y = price, label=price), vjust = -0.4) + 
  theme_bw() +
  coord_flip()

# treemap
library(treemap)
treemap(df,
        index="model",
        vSize="price",
        vColor="engineSize",
        palette = "PuBu",
        type="index")

# parallel plot
library(GGally)
df %>%
  mutate(price = mean(price)) %>%
  slice_sample(n=100) %>%
  ggparcoord(
    groupColumn = "model", columns=c(2,7,9),
    splineFactor = 10, showPoints = T,
  ) + scale_color_brewer(palette = "Paired") + theme_bw()


# scatter plot
scatterplot <- ggplot(data=df) + geom_point(aes(x=year, y=model, 
                                                  size=price,color = transmission), alpha=0.7) + xlim(NA,2025)
scatterplot + ggtitle("something")
  