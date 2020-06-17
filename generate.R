#####SETUP#####
suppressPackageStartupMessages(library("readr"))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("ggplot2"))
suppressPackageStartupMessages(library("maps"))

#####INPUT#####
pcare <- read_csv("state-data.csv")
covid <- read_csv("covid-cases.csv")
projected <- read_csv("ihme-projection.csv")

#####PROCESS#####
# pcare:
#   - add column for # of physicians over 60 per 100K population
#   IGNORE FOR NOW- only select states that can be plotted (remove DC, PR)
pcare <- pcare %>%
  mutate(Risk = Number * Over60 / 100) #%>%
  #filter(!(state %in% c("DC", "PR")))

# covid:
#   IGNORE FOR NOW- rename Long_ to long (contains longitude)
#   IGNORE FOR NOW- rename Lat to lat (contains latitude)
#   - remove rows w/ zero cases (won't be plotted anyway, won't cause logarithm issues)
#   IGNORE FOR NOW- remove rows not in continental United States
#   IGNORE FOR NOW- take logarithm to make bubbles more aesthetically pleasing
covid <- covid %>%
  #rename(long = Long_) %>%
  #rename(lat = Lat) %>%
  filter(`6/4/2020` > 0)
  #filter(lat > 25 & lat < 50 & long > -130 & long < -65) %>%
  #mutate(LogCases = log10(`6/4/2020`)) %>%

# projected:
#   - summarise (sum) by state for projected cases as of 1-Oct-2020
projected <- projected %>%
  group_by(region) %>%
  summarise(Projected = sum(est_infections_mean))

# join pcare & covid then standardize cases to per 100K population, then only select relevant columns
#   then add projected cases then standardize to per 100K population, then only select relevant columns
pcare <- pcare %>%
  left_join(covid) %>%
  mutate(Current = `6/4/2020` / TotalPop * 100000) %>%
  left_join(projected) %>%
  mutate(Projection = Projected / TotalPop * 100000) %>%
  select(region, state, Number, Risk,
         Current, Projection, Long, Lat) %>%
  mutate(Remaining = Number - Risk,
         curr_conc = Current / Remaining,
         proj_conc = Projection / Remaining)

# LOOK AT DATA HERE BEFORE NON-CONTINENTAL STATES ARE REMOVED

# prepare map data
pcare <- filter(pcare, !(region %in% c("puerto rico",
                                       "district of columbia",
                                       "alaska",
                                       "hawaii")))
states_pleth <- map_data("state")
state_data <- left_join(states_pleth, pcare, by = "region")

#####VISUALIZE & SAVE#####
## bubble map of 50 U.S. states
ggplot(data = state_data) +
  # map w/ states colored by # `physicians over 60` per 100K population
  geom_polygon(aes(x = long, y = lat, group = group, fill = Risk),
               color = "black") +
  scale_fill_gradient("At-risk", low = "white", high = "darkblue") +
  # bubbles w/ log(COVID cases)
  geom_point(aes(x = Long, y = Lat, size = Current),
             color = "orange") +
  scale_size_continuous("SARS-CoV-2 cases", range = c(1, 8)) +
  #scale_size_continuous("# cases",
  #                      range = c(0, 1.15),
  #                      labels = c("1-9", "10-99", "100-999",
  #                                 "1,000-9,999", "10,000-99,999",
  #                                 ">100,000")) +
  # remove elements we don't need
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank())

# save bubble chloropleth
ggsave(filename = "BubbleMap.png",
       width = 8, height = 4)

