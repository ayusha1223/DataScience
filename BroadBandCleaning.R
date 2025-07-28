# Load necessary library
library(tidyverse)

# Define the path to the raw broadband data
broadband_file <- "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/201805_fixed_pc_performance_r03.csv"

# Read the raw broadband CSV file
broadband_raw <- read_csv(broadband_file, show_col_types = FALSE)

# Clean and transform the data
broadband_cleaned <- broadband_raw %>%
  mutate(
    shortPostcode = substr(str_trim(postcode_space), 1, 4),     # extract outward code
    broadband_id = row_number()
  ) %>%
  select(
    broadband_id,
    postcode_area = `postcode area`,
    shortPostcode,
    avg_download = `Average download speed (Mbit/s)`,
    avg_upload = `Average upload speed (Mbit/s)`,
    min_download = `Minimum download speed (Mbit/s)`,
    min_upload = `Minimum upload speed (Mbit/s)`
  ) %>%
  drop_na() %>%
  distinct()

# Save the cleaned broadband data to cleaned_data folder
write_csv(broadband_cleaned, "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/broadband_cleaned.csv")

# Done message
print("✅ Broadband speed data cleaned and saved successfully!")
