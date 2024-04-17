data <- map(
  .x = selection_of_countries,
  .f = \(x) wpp_age(x, "2015")) %>% 
  set_names(selection_of_countries)

data_pop <- map(
  .x = data,
  .f = \(x) as_conmat_population(
    x,
    age = lower.age.limit, 
    population = population))

data_pop

temp <- std_wpp_data
list_temp <- split(temp, temp$country_names)

temp_pop <- map(
  .x = list_temp,
  .f = \(x) as_conmat_population(
    x,
    age = lower_age_limit, 
    population = population))
