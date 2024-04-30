# Figure out standardisation of country names

tar_load(standardised_wpp_data)
std_wpp_list <- standardised_wpp_data %>% 
  distinct(country_names) %>% 
  rename(country = country_names)

nonstd_names <- anti_join(std_wpp_list, wpp_names_list)

# From other branch
write_csv(wpp_names_list, "./data/wpp_country_names.csv")
write_csv(std_wpp_list, "./data/std_wpp_country_names.csv")
write_csv(prem17, "./data/prem_2017_country_names.csv")
write_csv(un_countries, "./data/un_country_names.csv")

# Try this out

library(tidyverse)
library(targets)
library(tarchetypes)

wpp_countrynames <- read_csv("./data/wpp_country_names.csv") %>% 
  as_tibble()
un_countrynames <- read_csv("./data/un_country_names.csv") %>% 
  as_tibble()
prem17_countrynames <- read_csv("./data/prem_2017_country_names.csv") %>% 
  as_tibble()

# Figure out which countries included
tar_load(standardised_wpp_data)
std_wpp_countrynames <- standardised_wpp_data %>% 
  distinct(std_country_names) %>% 
  select(std_country_names) %>% 
  rename(country = country_names)

# Countries in WPP that is not in the standardised form
excluded_wpp_names <- anti_join(wpp_countrynames, std_wpp_countrynames, by = "country")

# Fuzzy join --------------

excluded_wpp_countrynames <- standardised_wpp_data %>% 
  filter(is.na(std_country_names)) %>% 
  select(country) %>% 
  distinct(country)

library(fuzzyjoin)

# Let the "gold standard" be the UN country names
fuzz <- stringdist_inner_join(excluded_wpp_countrynames, un_countrynames, by = "country")

fuzz <- fuzz %>% 
  select(country.x, std_country) %>% 
  rename(country = country.x) %>% 
  mutate(country = case_when(
    country == "Congo" & std_country == "Togo" ~ NA,
  )
)

check_cm_equal("./output/240427 all countries output/Albania/Albania_other_2015.csv",
               "./output/240403 all regions contact matrices/Albania/Albania_other_2015.csv")

# Re-writing for tidyverse -----

standardise_country_names <- function(data,
                                      column_name,
                                      conversion_destination_code = "country.name.en"
) {
  
  data_1 <- data %>% 
    mutate(std_country_names = countrycode::countryname(
      {{ column_name }},
      destination = conversion_destination_code,
      nomatch = NA,
      warn = TRUE
    ))
  
  data_out <- data_1 %>%
    select({{ column_name }}, std_country_names, lower.age.limit, year, population) %>% 
    rename(lower_age_limit = lower.age.limit) %>% 
    arrange({{ column_name }}, lower_age_limit)
  
  data_out
}

temp <- standardise_country_names(cleaned_wpp, country)
