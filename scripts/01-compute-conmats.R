source("./scripts/00-setup.R")

# Extract data up to extrapolate_polymod ---------------

dat <- wpp_age()

# Check for missing values
temp1 <- dat %>% filter(is.na(population))

temp1 %>% count(lower.age.limit) # 85-100: 1,928 missing values each
temp1 %>% count(country) # All 241 obs: 32 missing values each
temp1 %>% count(year) # 1950-1985: 964 missing values each

rm("temp1")

# Grab country names only, then standardise

all_countries <- read.csv("./raw/all-countries.csv") # From UN
all_countries <- all_countries %>% select(name)

list_country <- dat %>% 
  distinct(country)

list_country_std <- inner_join(list_country, all_countries, by = c("country" = "name"))
list_country_std <- list_country_std %>% pull(country) %>% as.character

# map country-year pairs to data_from_missing ----------------

#%% Test first 3 countries -----

test <- list_country_std[1:3]

# Step 1: extract from wpp_age

tdat <- map(test, 
            \(x) wpp_age(x, "2015")) %>% 
  set_names(test)

# Step 2: as_conmat_population

tdat_pop <- map(tdat, 
                \(x) as_conmat_population(x, 
                                          age = lower.age.limit, 
                                          population = population)) %>% 
  set_names(test)

# Step 3: extrapolate_polymod

age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)

tdat_contact <- map(tdat_pop,
                    \(x) extrapolate_polymod(x, 
                                             age_breaks = age_breaks_0_80_plus)) %>% 
  set_names(test)

#TODO Now iterate through each list and save each as csv
# eg 2015_Afghanistan_home.csv, 2015_Afghanistan_work.csv
tdat_contact$Afghanistan$home

#TODO How to save the results? countryname.year for each matrix?
# as_tibble for each element going through the list_countries and list_years?
# Also this takes a while so putting it into targets workflow is a good idea... but how?

#TODO Write up function with this?