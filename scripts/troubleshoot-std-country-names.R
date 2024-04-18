# Figure out standardisation of country names

tar_load(standardised_wpp_data)
std_wpp_list <- standardised_wpp_data %>% 
  distinct(country_names) %>% 
  rename(country = country_names)

nonstd_names <- anti_join(std_wpp_list, wpp_names_list)
