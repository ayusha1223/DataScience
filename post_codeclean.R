# Load required package
library(tidyverse)

# Step 1: Load cleaned town + population data
town_pop_data <- read_csv(
  "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/town_population.csv",
  show_col_types = FALSE
)

# Step 2: Load postcode-to-LSOA mapping file
postcode_lsoa <- read_csv(
  "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/Postcode to LSOA.csv",
  show_col_types = FALSE
)

# Step 3: Clean and prepare LSOA + town data
postcode_lsoa_cleaned <- postcode_lsoa %>%
  select(LSOA_code = lsoa11cd, postcode = pcds) %>%
  mutate(shortPostcode = str_extract(postcode, "^[^ ]+")) %>%
  right_join(town_pop_data, by = "shortPostcode") %>%
  select(
    LSOA_code, shortPostcode, Town, District, County,
    Population2020, Population2021, Population2022, Population2023, Population2024
  ) %>%
  distinct() %>%
  group_by(LSOA_code)

# Step 4: Save to CSV
write_csv(
  postcode_lsoa_cleaned,
  "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/Cleaned_LSOA.csv"
)

# Step 5: View cleaned data
View(postcode_lsoa_cleaned)
