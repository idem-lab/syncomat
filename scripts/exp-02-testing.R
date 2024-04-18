# Validating country names ---------

#%% Manually work through wpp_age ------------------

distinct_country_names <- wpp_age %>% distinct(country)

write_csv(distinct_country_names, "./output/wpp names.csv")

#%% Using contactdata ------------------

library(contactdata)
contact_countries()

prem17 <- list_countries(data_source = 2017)

countrycode_countries <- country_list
