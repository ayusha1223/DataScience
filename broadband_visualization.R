# Load required libraries
library(tidyverse)

# Load the cleaned broadband data
broadband_data <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/broadband_cleaned.csv")

# === 1. Boxplots for average download speed for both counties ===
ggplot(broadband_data, aes(x = District, y = Avg_Download_Speed_Mbps)) +
  geom_boxplot() +
  coord_flip() +
  facet_wrap(~County) +
  labs(
    title = "Download Speed Distribution by District (Each County)",
    x = "District", y = "Download Speed (Mbps)"
  ) +
  theme_minimal()

# === 2. Bar charts for average download speeds by town (separate for both counties) ===
ggplot(broadband_data, aes(x = reorder(Town, Avg_Download_Speed_Mbps), y = Avg_Download_Speed_Mbps, fill = County)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~County) +
  labs(
    title = "Average Download Speeds by Town (Each County)",
    x = "Town", y = "Download Speed (Mbps)"
  ) +
  theme_minimal()
