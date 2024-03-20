source("./scripts/00-setup.R")

# Extract data up to extrapolate_polymod ---------------

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
  select(name)

list_country <- dat %>% 
  distinct(country)

list_country <- inner_join(list_country, all_countries, by = c("country" = "name"))
list_country <- list_country %>% pull(country) %>% as.character

rm(all_countries)

#%% Test first 3 countries -----

test_countries <- list_country[1:3]

# Step 1: extract from wpp_age

tdat <- map(test_countries, 
            \(x) wpp_age(x, "2015")) %>% 
  set_names(test_countries)

# Step 2: as_conmat_population

tdat_pop <- map(tdat, 
                \(x) as_conmat_population(x, 
                                          age = lower.age.limit, 
                                          population = population)) %>% 
  set_names(test_countries)

# Step 3: extrapolate_polymod

age_breaks_0_80_plus <- c(seq(0, 80, by = 5), Inf)

tdat_contact <- map(tdat_pop,
                    \(x) extrapolate_polymod(x, 
                                             age_breaks = age_breaks_0_80_plus)) %>% 
  set_names(test_countries)

#TODO Write up function with this?

#%% All of the POLYMOD data ---------------------

#TODO how do I put this in a targets workflow?

# Save as csv files ------------------------

save_conmat_as_csv <- function(matrix_list, path = "./") {
  for (country_name in names(matrix_list)) {
    country_matrices <- matrix_list[[country_name]]
    
    for (matrix_name in names(country_matrices)) {
      matrix_data <- country_matrices[[matrix_name]]
      file_name <- sprintf("%s_%s_%s.csv", country_name, matrix_name, "2015")
      file_path <- file.path(path, file_name)
      write.csv(matrix_data, file_path, row.names = TRUE)
    }
  }
}

#%% Test files (3 countries) -------------

save_conmat_as_csv(tdat_contact, path = "./output/")
