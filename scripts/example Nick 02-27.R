library(socialmixr)
library(conmat)

italy_2005 <- wpp_age("Italy", "2005")

head(italy_2005)

italy_2005_pop <- as_conmat_population(
  data = italy_2005,
  age = lower.age.limit,
  population = population
)

italy_2005_pop
age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)

italy_contact <- extrapolate_polymod(
  population = italy_2005_pop,
  age_breaks = age_breaks_0_80_plus
)

italy_contact

autoplot(italy_contact$home)

# what if more countries?
available_countries <- wpp_countries()

available_countries[1]

new_country_1 <- wpp_age(available_countries[1], years = "2005")

head(new_country_1)

new_country_2005_pop <- as_conmat_population(
  data = new_country_1,
  age = lower.age.limit,
  population = population
)

new_country_2005_pop

age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)

new_country_contact <- extrapolate_polymod(
  population = new_country_2005_pop,
  age_breaks = age_breaks_0_80_plus
)

new_country_contact

# what if three countries at once?

countries_of_interest <- available_countries[1:3]

new_country_1 <- wpp_age(available_countries[1], years = "2005")
new_countries <- map(
  .x = countries_of_interest, 
  .f = wpp_age, 
  years = "2005",
)

# fun naming of the list
names(new_countries)
names(new_countries) <- countries_of_interest
names(new_countries)
str(new_countries)
class(new_countries)
new_countries[[1]]
new_countries$Burundi

countries_population <- map(
  .x = new_countries,
  .f = function(x) {
    as_conmat_population(
      data = x,
      age = lower.age.limit,
      population = population
    )
  }
)

countries_population

age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)

countries_contact_matrices <- map(
  .x = countries_population,
  .f = function(x){
    extrapolate_polymod(
      population = x,
      age_breaks = age_breaks_0_80_plus
    )
  }
)

# an exercise for fun from here - save these as CSV files
countries_contact_matrices$Burundi
countries_contact_matrices$Burundi$home

## TODO tasks
## Get this to work for 10 countries
## write out CSV files for a few countries
## put this up on github
## write this out as a targets workflow :)
