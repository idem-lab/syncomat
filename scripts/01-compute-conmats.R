source("./scripts/00-setup.R")

# Set-up: Grab data from wpp_age() ---------------

dat <- wpp_age()

# Check for missing values
# temp1 <- dat %>% filter(is.na(population))
# 
# temp1 %>% count(lower.age.limit) # 85-100: 1,928 missing values each
# temp1 %>% count(country) # All 241 obs: 32 missing values each
# temp1 %>% count(year) # 1950-1985: 964 missing values each
# 
# rm("temp1")

# Grab country names only, then standardise

# From UN
all_countries <- read_csv("./raw/all-countries.csv") %>% 
  #TODO add link in as comment
  select(name)

list_country <- dat %>% 
  distinct(country)

list_country <- inner_join(list_country, all_countries, by = c("country" = "name"))
list_country <- list_country %>% pull(country) %>% as.character

rm(all_countries)

# Create contact matrices --------

create_pop_data <- function(country_list){
  # This function takes the list of countries,
  # plugs it into wpp_age() 
  # and subsequently as_conmat_population()
  # to derive the population data.
  
  data <- map(country_list, 
              \(x) wpp_age(x, "2015")) %>% 
    set_names(country_list)
  
  data_pop <- map(data, 
                  \(x) as_conmat_population(x, 
                                            age = lower.age.limit, 
                                            population = population)) %>% 
    set_names(country_list)
  
  data_pop
}

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

#%% Test first 3 countries ----------

test_countries <- list_country[1:3]
testdat_pop <- create_pop_data(test_countries)
testdat_contact <- create_contact_matrices_0to80(testdat_pop, test_countries)

#%% All of the POLYMOD data ---------------------

#TODO

test_list <- c("Belize", "France", "Indonesia")

dat_pop <- create_pop_data(test_list)
dat_contact <- create_contact_matrices(dat_pop, test_list, 0, 80)
save_conmat_as_csv(dat_contact, path = "./output/240327 test")

check_cm_equal("./output/240327 test/Belize_home_2015.csv",
               "./output/240326 all/Belize/Belize_home_2015.csv")

check_cm_equal("./output/240327 test/France_school_2015.csv",
               "./output/240326 all/France/France_school_2015.csv")

check_cm_equal("./output/240327 test/Indonesia_all_2015.csv",
               "./output/240326 all/Indonesia/Indonesia_all_2015.csv")

check_cm_equal("./output/240327 test/Indonesia_all_2015.csv",
               "./output/240326 all/France/France_school_2015.csv")

# Save as csv files ------------------------

#TODO in a directory for each country?
# pkg fs::dir_create
# pkg glue

save_conmat_as_csv <- function(matrix_list, path = "./") {
  for (country_name in names(matrix_list)) {
    country_matrices <- matrix_list[[country_name]]
    
    for (matrix_name in names(country_matrices)) {
      matrix_data <- country_matrices[[matrix_name]]
      file_name <- sprintf("%s_%s_%s.csv", country_name, matrix_name, "2015") #TODO glue
      file_path <- file.path(path, file_name)
      write.csv(matrix_data, file_path, row.names = TRUE)
    }
  }
}

#%% Test creating csv files (3 countries) -------------

save_conmat_as_csv(testdat_contact, path = "./output/")
