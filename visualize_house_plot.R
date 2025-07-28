# Load required libraries
library(tidyverse)

# Step 1: Load cleaned data
house_data <- read_csv("C:/Users/Acer/OneDrive/Desktop/DataScienceProject/cleaned_data/house_cleaned.csv")

# Step 2: Filter only relevant years and counties (2021–2024)
filtered_data <- house_data %>%
  filter(Year %in% c("2021", "2022", "2023", "2024")) %>%
  filter(County %in% c("SOUTH YORKSHIRE", "WEST YORKSHIRE"))

# Step 3: Compute average prices per district and year
avg_price_by_year <- filtered_data %>%
  group_by(Year, District, County) %>%
  summarise(AvgPrice = mean(Price, na.rm = TRUE), .groups = "drop")

# Step 4: Line graph — Average prices 2021–2024 by district and county
ggplot(avg_price_by_year, aes(x = Year, y = AvgPrice, group = District, color = District)) +
  geom_line(size = 1.2) +
  facet_wrap(~County) +
  labs(title = "Line Graph: Avg House Prices (2021–2024)", y = "Average Price", x = "Year") +
  theme_minimal()

# Step 5: Bar chart — Avg prices for 2023 by district
avg_price_2023 <- filtered_data %>%
  filter(Year == "2023") %>%
  group_by(District, County) %>%
  summarise(AvgPrice = mean(Price, na.rm = TRUE), .groups = "drop")

ggplot(avg_price_2023, aes(x = reorder(District, AvgPrice), y = AvgPrice, fill = County)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip() +
  labs(title = "Bar Chart: Avg House Prices in 2023", y = "Average Price", x = "District") +
  theme_minimal()

# Step 6: Boxplot — Distribution of prices per district, faceted by county
ggplot(filtered_data, aes(x = District, y = Price)) +
  geom_boxplot(aes(fill = County)) +
  facet_wrap(~County, scales = "free") +
  coord_flip() +
  labs(title = "Boxplot: House Price Distribution by District", y = "Price", x = "District") +
  theme_minimal()
