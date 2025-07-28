library(tidyverse)

# 1. Load town + population dataset (your cleaned version)
town_pop_data <- read_csv(
  "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/town_population.csv",
  show_col_types = FALSE
)

# 2. Load Postcode to LSOA mapping data
lsoa_mapping <- read_csv(
  "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/Postcode to LSOA.csv",
  show_col_types = FALSE
)

# 3. Clean + Join using shared postcode prefix
lsoa_processed <- lsoa_mapping %>%
  select(lsoa11cd, pcds) %>%
  mutate(shortPostcode = str_remove(pcds, " .*$")) %>%
  right_join(town_pop_data, by = "shortPostcode") %>%
  group_by(lsoa11cd) %>%
  select(
    lsoa11cd, shortPostcode, Town, District, County,
    Population2020, Population2021, Population2022, Population2023, Population2024
  ) %>%
  distinct()

# 4. Rename LSOA column
lsoa_final <- lsoa_processed %>%
  rename(LSOA_code = lsoa11cd)

# 5. Save the result
write_csv(
  lsoa_final,
  "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/Cleaned_LSOA.csv"
)

# 6. Confirm success
print("✅ Cleaned LSOA file generated and saved!")
