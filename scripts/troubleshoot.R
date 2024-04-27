in_data_wpp <- wpp_age(years = 2015)

wpp_age <- wpp_age(years = 2015)

std_wpp_data <- standardise_country_names(in_data_wpp, "country")


sel_countries <- std_wpp_data[1:3,]

data_pop <- map(
  .x = sel_countries,
  .f = \(x) as_conmat_population(
    x,
    age = lower_age_limit,
    population = population
  )
)
