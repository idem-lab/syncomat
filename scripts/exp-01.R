source("./scripts/00-setup.R")

# 1 - Initial EDA ----

#%% Exploring wpp_age -----

# Using data from the wpp2017 package.

dat <- wpp_age()

# Countries, continents, and developing region types provided
dat %>% expand(country) %>% print(n = 250)
# wpp_countries() only gives 199 countries, but total of 241
#     i.e. 42 more including "WORLD" and development regions in data

# How many years? Only 15y in 5y increments 1950-2015
dat %>% expand(year)

# Notes
# - Data will always have vars: country, lower.age.limit, year, population

#%% Issue with NAs in extrapolate_polymod ------

AFG1950 <- wpp_age("Afghanistan", "1950")

AFG1950_pop <- as_conmat_population(
  data = AFG1950,
  age = lower.age.limit,
  population = population
)

# Still looks the same at this point, but as it should.

age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)

AFG1950_contact <- extrapolate_polymod(
  population = AFG1950_pop,
  age_breaks = age_breaks_0_80_plus
)
# This runs into an issue because in AFG 1950,
#   no data for 85+ age groups. 

# Q How do I find which countries, age groups, and years 
#   have missing values?
# 1 - Perhaps I can convert this to a wide data?

temp1 <- dat %>% pivot_wider(
  names_from = lower.age.limit,
  values_from = c(country, year)
)

# 2 - Simply summarise missing
temp1 <- dat %>% filter(is.na(population))

temp1 %>% count(lower.age.limit) # 85-100: 1,928 missing values each
temp1 %>% count(country) # All 241 obs: 32 missing values each
temp1 %>% count(year) # 1950-1985: 964 missing values each

# Q Which countries did NOT have missing values for their 85-100 groups?
# A None. All of them have missing values.

#%% If missing, remove. -----
# Instance of AFG 1950

AFG1950 <- wpp_age("Afghanistan", "1950") %>% 
  filter(!is.na(population))

AFG1950_pop <- as_conmat_population(
  data = AFG1950,
  age = lower.age.limit,
  population = population
)

age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)
s
AFG1950_contact <- extrapolate_polymod(
  population = AFG1950_pop,
  age_breaks = age_breaks_0_80_plus
)

#%% Function to remove missing values -----

#DONE Write a function that either changes the lower.age.limit in the data
#     to regroup to 80+ only or do something about the extrapolate function
#     (check w Nick)

data_from_missing <- function(country, year){
  
  # Remove NA rows if missing from wpp_age()
  # From EDA we know that it's 85+ 1950-1985 only
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

test_AFG1950 <- data_from_missing("Afghanistan", "1950")
test_AFRICA1950 <- data_from_missing("AFRICA", "1950") # Doesn't work. 

rm(temp1)

# Create conmats for country-years --------

#%% Extract countries and years ----

# This extracts the regions 
list_regions_country_year <- dat %>% 
  distinct(country, year) %>% 
  filter(str_detect(country, "^[[:upper:]]+$"))

# Grab country names only, then standardise

all_countries <- read.csv("./raw/all-countries.csv")
all_countries <- all_countries %>% select(name)

list_country_year <- dat %>% 
  distinct(country, year)

list_country_year_std <- inner_join(list_country_year, all_countries, by = c("country" = "name"))

# Create country-year pairs to plug into map

list_countries <- list_country_year_std %>% pull(country) %>% as.character
list_years <- list_country_year_std %>% pull(year)

#%% Map to data_from_missing function -----

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

#TODO next: write up function with this

# Create conmats for each country -------------------------

#%% Test for 3 ------------------------
test_countries <- list_country[1:3]

create_pop_data <- function(country_list){
  # This function takes the list of countries,
  # plugs it into wpp_age() 
  # and subsequently as_conmat_population()
  # to derive the population data.
  
  data <- map(country_list, 
              \(x) wpp_age(x, "2015")) %>% 
    set_names(country_list)
  
  data_pop <- map(tdat, 
                  \(x) as_conmat_population(x, 
                                            age = lower.age.limit, 
                                            population = population)) %>% 
    set_names(country_list)
  
  data_pop
}

testdat_pop <- create_pop_data(test_countries)

create_contact_matrices_0to80 <- function(data_pop, country_list){
  # This function takes the population data and the list of countries
  # derived from as_conmat_population()
  # and subsequently uses extrapolate_polymod()
  # to derive the social contact matrices
  
  age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)
  
  data_contact <- map(data_pop,
                      \(x) extrapolate_polymod(x, 
                                               age_breaks = age_breaks_0_80_plus)) %>% 
    set_names(country_list)
  
  data_contact
}

testdat_contact <- create_contact_matrices_0to80(testdat_pop, test_countries)


# Susbetting exercise -----------

# Set up data for testing:
# tdat, tdat_pop, tdat_contact

str(tdat)

t1 <- tdat[1]
t1 <- tdat["Algeria"]

# Either one of these methods work
tdat_contact$Afghanistan$home
t1 <- tdat_contact["Afghanistan"]
dat1 <- as.data.frame(t1$Afghanistan$other)
t2 <- tdat_contact[["Afghanistan"]]
dat2 <- as.data.frame(t2$other)

write.csv(dat2, "./output/Afghanistan_other.csv", row.names = TRUE)

str(tdat_contact)

save_matrices_as_csv <- function(country_list, matrix_list, path = "./") {
  for (country_name in country_list) {
    country_matrices <- matrix_list[[country_name]]
    
    for (matrix_name in names(country_matrices)) {
      matrix_data <- country_matrices[[matrix_name]]
      file_name <- sprintf("%s_%s.csv", country_name, matrix_name)
      file_path <- file.path(path, file_name)
      write.csv(matrix_data, file_path, row.names = TRUE)
    }
  }
}

save_matrices_as_csv(test_countries, tdat_contact, path = "./output/")

# Do it again but with names inside the matrix list already
savemat_for <- function(matrix_list, path = "./") {
  for (country_name in names(matrix_list)) {
    country_matrices <- matrix_list[[country_name]]
    
    for (matrix_name in names(country_matrices)) {
      matrix_data <- country_matrices[[matrix_name]]
      file_name <- sprintf("%s_%s.csv", country_name, matrix_name)
      file_path <- file.path(path, file_name)
      write.csv(matrix_data, file_path, row.names = TRUE)
    }
  }
}

# map version
savemat_map <- function(matrix_list, path = "./") {
  map(names(matrix_list), ~ {
    country_name <- .
    country_matrices <- matrix_list[[country_name]]
    
    map(names(country_matrices), ~ {
      matrix_name <- .
      matrix_data <- country_matrices[[matrix_name]]
      file_name <- sprintf("%s_%s.csv", country_name, matrix_name)
      file_path <- file.path(path, file_name)
      write.csv(matrix_data, file_path, row.names = TRUE)
    })
  })
}

microbenchmark(
  tmap = savemat_map(tdat_contact),
  tfor = savemat_for(tdat_contact)
)
