distinct_country_names <- wpp_age %>% distinct(country)

write_csv(distinct_country_names, "./output/wpp names.csv")
