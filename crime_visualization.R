# Load libraries
library(tidyverse)
library(fmsb)     # for radar chart
library(scales)   # for pie chart

# Read data
crime_data <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/crime_cleaned.csv")

# ========== 1. Boxplot for Drug offense rate (District vs Rate) per County ==========
ggplot(crime_data, aes(x = District, y = drug_offense_rate)) +
  geom_boxplot(fill = "lightblue") +
  coord_flip() +
  facet_wrap(~County) +   # County must be in both data and aes
  labs(
    title = "Drug Offense Rate by District (Each County)",
    x = "District",
    y = "Drug Offense Rate"
  ) +
  theme_minimal()

# ========== 2. Radar Chart for Vehicle crime (Jan 2022, West Yorkshire) ==========
radar_data <- crime_data %>%
  filter(County == "West Yorkshire", Month == "January", Year == 2022) %>%
  select(District, vehicle_crime_rate) %>%
  distinct()

radar_df <- as.data.frame(t(radar_data$vehicle_crime_rate))
colnames(radar_df) <- radar_data$District
radar_df <- rbind(rep(max(radar_df), ncol(radar_df)),
                  rep(0, ncol(radar_df)),
                  radar_df)

radarchart(radar_df,
           axistype = 1,
           pcol = "red",
           pfcol = rgb(1, 0, 0, 0.3),
           plwd = 2,
           cglcol = "grey",
           axislabcol = "grey",
           caxislabels = seq(0, max(radar_df[1,]), length.out = 5),
           title = "Vehicle Crime Rate - West Yorkshire (Jan 2022)")

# ========== 3. Pie Chart for Robbery Rate (Jan 2022, South Yorkshire) ==========
pie_data <- crime_data %>%
  filter(County == "South Yorkshire", Month == "January", Year == 2022) %>%
  group_by(District) %>%
  summarise(RobberyRate = sum(robbery_rate, na.rm = TRUE))

ggplot(pie_data, aes(x = "", y = RobberyRate, fill = District)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Robbery Rate by District - South Yorkshire (Jan 2022)") +
  theme_void() +
  scale_fill_brewer(palette = "Set3")

# ========== 4. Line Chart for Drug offense rate per 10,000 people ==========
line_data <- crime_data %>%
  group_by(Year, County) %>%
  summarise(
    total_drug = sum(drug_offense_rate * population / 10000, na.rm = TRUE),
    total_pop = sum(population, na.rm = TRUE),
    rate_per_10k = total_drug / (total_pop / 10000)
  )

ggplot(line_data, aes(x = Year, y = rate_per_10k, color = County)) +
  geom_line(size = 1.2) +
  geom_point() +
  labs(
    title = "Drug Offense Rate per 10,000 People (All Years)",
    x = "Year",
    y = "Rate per 10,000 People"
  ) +
  theme_minimal()
