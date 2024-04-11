source("./scripts/00-setup.R")

list_surveys()

# Example
peru_survey <- get_survey("https://doi.org/10.5281/zenodo.1095664")
saveRDS(peru_survey, "peru.rds")

# The following doesn't work
survey_list <- list_surveys()

# From Zenodo
belgium20 <- get_survey("https://zenodo.org/records/10549953")
saveRDS(belgium20, "./data/belgium2020.rds")

View(belgium20$participants)
belg20_contacts <- belgium20$contacts
View(belgium20$reference)

t_agegroups <- belg20_contacts %>% 
  select(cnt_age_est_min, cnt_age_est_max) %>% 
  distinct() %>% 
  arrange(cnt_age_est_min)

# Compare our data with contactdata package -----------------------
library(contactdata)
library(countrycode)

cd_2017 <- list_countries(data_source = 2017)
cd_2020 <- list_countries(data_source = 2020)

t_clist_15 <- as.data.frame(country_list) %>% 
  rename(l15 = country_list)
t_clist_17 <- as.data.frame(cd_2017) %>% 
  rename(l17 = cd_2017)
t_clist_20 <- as.data.frame(cd_2020) %>% 
  rename(l20 = cd_2020)

# Which countries are in our list but not on their list?
anti_join(t_clist_15, t_clist_17, by = c("l15" = "l17"))

# Which are in their list but not on our list?
anti_join(t_clist_17, t_clist_15, by = c("l17" = "l15"))

# Find a way to remove the ones that are similar.
standardise_country_name <- function(data, var_in){
  countrycode::countryname(glue("{data}${var_in}"),
                           destination = "country.name.en",
                           nomatch = NA,
                           warn = TRUE)
}



t_clist_15$countries <- standardise_country_name(t_clist_15, l15)

map_world <- map_data("world")
map_world$region <- countrycode::countryname(map_world$region)

map_world$included <- "Not included"


map_world$included[map_world$region %in% t_clist_combined] <- "contactdata"
map_world$included[map_world$region %in% country_list] <- "Our data"

ggplot(map_world, aes(long, lat, group = group, fill = included)) +
  geom_polygon() +
  coord_equal() +
  theme_bw()
