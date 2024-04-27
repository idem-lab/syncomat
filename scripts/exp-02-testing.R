# Validating country names ---------

#%% Manually work through wpp_age ------------------

distinct_country_names <- wpp_age %>% distinct(country)

write_csv(distinct_country_names, "./output/wpp names.csv")

#%% Using contactdata ------------------

library(contactdata)
contact_countries()

# List of countries from Prem
prem17 <- list_countries(data_source = 2017)
prem17 <- as_tibble(prem17) %>% 
  rename(country = value)
prem17 <- standardise_country_names(prem17, "country")

# List of countries from countrycode package, merged with wpp
# First run tar_make(country_list)
countrycode_countries <- country_list
countrycode_countries <- as_tibble(countrycode_countries) %>% 
  rename(country = value)

# List of countries from csv file: UN ISO 3166 standard 2020, merged with wpp
# First run tar_make(country_list)
un_countries <- country_list
un_countries <- as_tibble(un_countries) %>% 
  rename(country = value)
un_countries <- standardise_country_names(un_countries, "country")

wpp_names_list <- wpp_data %>% distinct(country)

# Countries in Prem not in our wpp data
prem_not_un <- anti_join(prem17, un_countries, by = "std_country")

# Countries in our wpp data not in Prem
un_not_prem <- anti_join(un_countries, prem17, by = "std_country")
