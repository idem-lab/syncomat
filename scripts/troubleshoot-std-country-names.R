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

wpp_countrynames <- read_csv("./data/wpp_country_names.csv") %>% 
  as_tibble()
un_countrynames <- read_csv("./data/un_country_names.csv") %>% 
  as_tibble()
prem17_countrynames <- read_csv("./data/prem_2017_country_names.csv") %>% 
  as_tibble()

# Figure out which countries included
tar_load(standardised_wpp_data)
std_wpp_countrynames <- standardised_wpp_data %>% 
  distinct(country_names) %>% 
  select(country_names) %>% 
  rename(country = country_names)

# Countries in WPP that is not in the standardised form
excluded_wpp_names <- anti_join(wpp_countrynames, std_wpp_countrynames, by = "country")

# Fuzzy join --------------

library(fuzzyjoin)

# Let the "gold standard" be the UN country names
fuzz <- stringdist_inner_join(excluded_wpp_names, un_countrynames, by = "country")

fuzz <- fuzz %>% 
  select(country.x, std_country) %>% 
  rename(country = country.x) %>% 
  mutate(country = case_when(
    country == "Congo" & std_country == "Togo" ~ NA,
  )
  )