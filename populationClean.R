# Load library
library(tidyverse)

# Read your cleaned house price data
house_data <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/house_cleaned.csv")

# Read the raw population data file
population_raw <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/Population2011_1656567141570.csv", show_col_types = FALSE)

# Clean and project population for each year (2011 to 2024)
population_cleaned <- population_raw %>%
  mutate(shortPostcode = str_trim(substr(Postcode, 1, 4))) %>%
  group_by(shortPostcode) %>%
  summarise(Population2011 = sum(Population, na.rm = TRUE), .groups = "drop") %>%
  mutate(
    Population2012 = Population2011 * 1.00695,
    Population2013 = Population2012 * 1.00670,
    Population2014 = Population2013 * 1.00736,
    Population2015 = Population2014 * 1.00792,
    Population2016 = Population2015 * 1.00757,
    Population2017 = Population2016 * 1.00679,
    Population2018 = Population2017 * 1.00606,
    Population2019 = Population2018 * 1.00561,
    Population2020 = Population2019 * 1.00561,
    Population2021 = Population2020 * 1.00542,
    Population2022 = Population2021 * 1.00492,
    Population2023 = Population2022 * 1.00451,
    Population2024 = Population2023 * 1.00422
  ) %>%
  select(shortPostcode, Population2020:Population2024)

# Merge with house data to associate population with towns
town_population <- house_data %>%
  left_join(population_cleaned, by = "shortPostcode") %>%
  select(shortPostcode, Town, District, County, Population2020, Population2021, Population2022, Population2023, Population2024) %>%
  group_by(shortPostcode) %>%
  filter(row_number() == 1) %>%
  ungroup() %>%
  arrange(County)

# Save cleaned town+population data
write_csv(town_population, "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/town_population.csv")

print("✅ Town + Population data cleaned and saved successfully!")
