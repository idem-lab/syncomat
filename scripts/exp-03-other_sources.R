library(socialmixr)

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
