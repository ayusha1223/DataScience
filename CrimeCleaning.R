# Load necessary library
library(tidyverse)

# Define paths to your two crime files
south_file <- "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/2025-05-south-yorkshire-street.csv"
west_file  <- "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/2025-05-west-yorkshire-street.csv"

# Function to clean a single crime file
clean_crime_data <- function(file_path) {
  data <- read_csv(file_path, show_col_types = FALSE)
  
  # Check if required columns exist
  expected_cols <- c("Crime ID", "Month", "LSOA code", "Crime type", "LSOA name")
  
  if (all(expected_cols %in% colnames(data))) {
    data %>%
      filter(
        !is.na(`Crime ID`),
        !is.na(`LSOA code`),
        !is.na(`Crime type`),
        !is.na(Month)
      ) %>%
      mutate(
        Year = substr(Month, 1, 4),
        LSOA_code = `LSOA code`,
        CrimeType = `Crime type`
      ) %>%
      select(
        Month,
        Year,
        LSOA_code,
        `LSOA name`,
        CrimeType
      )
  } else {
    tibble()  # return empty tibble if columns are missing
  }
}

# Clean both files and combine
crime_cleaned <- bind_rows(
  clean_crime_data(south_file),
  clean_crime_data(west_file)
) %>%
  distinct() %>%
  arrange(Year, LSOA_code)

# Save cleaned file
write_csv(crime_cleaned, "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/crime_cleaned.csv")

# Confirmation
print("✅ Crime dataset cleaned and saved successfully!")
