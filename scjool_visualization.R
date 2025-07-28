# === Load required libraries ===
library(tidyverse)

# === Load Cleaned School Performance Data ===
school <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/Cleaned_School_Performance.csv")

# === Rename columns if needed (adjust these if your column names differ) ===
# Let's standardize the column names
school <- school %>%
  rename(
    County = County,                     # e.g., "South Yorkshire", "West Yorkshire"
    District = District,                 # e.g., "Sheffield", "Leeds"
    Year = Year,                         # Numeric year like 2022
    Attainment8Score = Attainment8Score # Numeric attainment score
  ) %>%
  filter(!is.na(Attainment8Score), !is.na(District), !is.na(County), !is.na(Year))

# === 1. Boxplot for Average Attainment 8 Score 2022 – South Yorkshire ===
south_box <- school %>%
  filter(County == "South Yorkshire", Year == 2022)

ggplot(south_box, aes(x = reorder(District, Attainment8Score, median), y = Attainment8Score)) +
  geom_boxplot(fill = "lightblue") +
  coord_flip() +
  labs(
    title = "Attainment 8 Score (2022) - South Yorkshire",
    x = "District",
    y = "Average Attainment 8 Score"
  ) +
  theme_minimal()

# === 2. Boxplot for Average Attainment 8 Score 2022 – West Yorkshire ===
west_box <- school %>%
  filter(County == "West Yorkshire", Year == 2022)

ggplot(west_box, aes(x = reorder(District, Attainment8Score, median), y = Attainment8Score)) +
  geom_boxplot(fill = "lightgreen") +
  coord_flip() +
  labs(
    title = "Attainment 8 Score (2022) - West Yorkshire",
    x = "District",
    y = "Average Attainment 8 Score"
  ) +
  theme_minimal()

# === 3. Line Chart: Attainment Score Over Years by District (Both Counties) ===
line_data <- school %>%
  filter(County %in% c("South Yorkshire", "West Yorkshire"))

ggplot(line_data, aes(x = Year, y = Attainment8Score, color = District)) +
  geom_line(size = 1.2) +
  geom_point() +
  facet_wrap(~County) +
  labs(
    title = "Attainment 8 Score Over Years by District",
    x = "Year",
    y = "Average Attainment 8 Score"
  ) +
  theme_minimal()
