source("./scripts/00-setup.R")

# Extract data up to extrapolate_polymod ---------------

dat <- wpp_age()

# Check for missing values
temp1 <- dat %>% filter(is.na(population))

temp1 %>% count(lower.age.limit) # 85-100: 1,928 missing values each
temp1 %>% count(country) # All 241 obs: 32 missing values each
temp1 %>% count(year) # 1950-1985: 964 missing values each

data_from_missing <- function(country, year){
  
  # A function that removes the missing rows in each country data
  # Then plugs it into as_conmat_population and extrapolate_polymod
  # Very much data-specific.
  # From EDA we know that it's 85+ 1950-1985 only for this dataset
  
  data_out <- wpp_age(country, year) %>% 
    filter(complete.cases(.))
  
  data_out_pop <- as_conmat_population(
    data = data_out,
    age = lower.age.limit,
    population = population
  )
  
  age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)
  
  data_out_contact <- extrapolate_polymod(
    population = data_out_pop,
    age_breaks = age_breaks_0_80_plus
  )
  
  data_out_contact
}

# Test cases
test_AFG1950 <- data_from_missing("Afghanistan", "1950")
test_AFRICA1950 <- data_from_missing("AFRICA", "1950") # Doesn't work. 

rm(list = ls(pattern = "temp"))
rm(list = ls(pattern = "test"))

# Extract countries and years of data --------------

# Grab country names only, then standardise

all_countries <- read.csv("./raw/all-countries.csv") # From UN
all_countries <- all_countries %>% select(name)

list_country_year <- dat %>% 
  distinct(country, year)

list_country_year_std <- inner_join(list_country_year, all_countries, by = c("country" = "name"))

# Create country-year pairs to plug into map

list_countries <- list_country_year_std %>% pull(country) %>% as.character
list_years <- list_country_year_std %>% pull(year)

# map country-year pairs to data_from_missing ----------------

#%%%% Test first three -----
test <- list_country_year_std %>% slice(1:3)
x <- test %>% pull(country) %>% as.character
y <- test %>% pull(year)

dat_test <- map2(x, y, data_from_missing)


#%%%% Test first 42 (3 countries) -----

test <- list_country_year_std %>% slice(1:42)
list_countries <- test %>% pull(country) %>% as.character
list_years <- test %>% pull(year)

dat_test <- map2(.x = list_countries,
                 .y = list_years,
                 .f = data_from_missing)

#TODO How to save the results? countryname.year for each matrix?
# as_tibble for each element going through the list_countries and list_years?
# Also this takes a while so putting it into targets workflow is a good idea... but how?

#TODO Write up function with this?