# Load required libraries
library(tidyverse)

# Define consistent column names based on data documentation
column_names <- c(
  "TransactionID", "Price", "DateOfTransfer", "Postcode", "PropertyType",
  "OldOrNew", "Duration", "PAON", "SAON", "Street", "Locality",
  "Town", "District", "County", "PPDCategoryType", "RecordStatus"
)


hp_2021 <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/pp-2021.csv", col_names = FALSE, show_col_types = FALSE)
hp_2022 <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/pp-2022.csv", col_names = FALSE, show_col_types = FALSE)
hp_2023 <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/raw_data/pp-2023.csv", col_names = FALSE, show_col_types = FALSE)

colnames(hp_2021) <- column_names
colnames(hp_2022) <- column_names
colnames(hp_2023) <- column_names


all_prices <- bind_rows(hp_2021, hp_2022, hp_2023) %>%
  distinct() %>%
  drop_na()

# Filter only for South and West Yorkshire
cleaned_prices <- all_prices %>%
  filter(County %in% c("SOUTH YORKSHIRE", "WEST YORKSHIRE")) %>%
  mutate(
    shortPostcode = sub(" .*$", "", Postcode),                    # Get outward postcode
    Year = format(as.Date(DateOfTransfer), "%Y"),                # Extract year
    Price = as.numeric(Price)                                    # Ensure Price is numeric
  ) %>%
  select(Postcode, shortPostcode, Year, PAON, Price, Town, District, County) %>%
  distinct() %>%
  drop_na()

# Save cleaned data
write_csv(cleaned_prices, "C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/house_cleaned.csv")

print("✅ Cleaned house price data saved successfully!")
