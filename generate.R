#####SETUP#####
library("readr")
library("dplyr")
library("ggplot2")
library("usmap")

#####INPUT#####
pcare <- read_csv("aamc-state-data.csv")

#####PROCESS#####
# add column for # of physicians per 100,000 population
pcare <- mutate(pcare, Risk = Number * Over60 / 100)

# only select states that can be plotted (remove DC, PR)
pcare_plot <- pcare[pcare$state != "DC" &
                    pcare$state != "PR", ]

#####VISUALIZE & SAVE#####
# map of 50 U.S. states
plot_usmap(data = pcare_plot, values = "Risk", color = "black") +
  scale_fill_gradient(name = "At-risk",
                      low = "white", high = "black") +
  theme(legend.position = "right")

# histogram of Risk column in pcare (probably won't use)
ggplot(data = pcare, aes(x = Risk)) +
  geom_histogram() +
  theme_bw()