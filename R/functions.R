create_country_list_from_wpp <- function(wpp_data){
  
  # Returns all countries in the dataset in list form.
  
  all_countries <- read_csv("./raw/all-countries.csv") %>% 
    select(country = name)
  
  wpp_countries <- wpp_data %>% 
    distinct(country)
  
  list_of_countries <- inner_join(wpp_countries, all_countries, by = "country")
  list_of_countries <- list_of_countries %>% 
    pull(country) %>% 
    as.character
  
  list_of_countries
}

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

create_contact_matrices <- function(data_pop, country_list, start_age = 0, end_age = 80){
  
  # This function takes the population data and the list of countries
  # derived from as_conmat_population()
  # and subsequently uses extrapolate_polymod()
  # to derive the social contact matrices
  
  age_breaks_0_80_plus <- c(seq(start_age, end_age, by = 5), Inf)
  
  data_contact <- map(data_pop,
                      \(x) extrapolate_polymod(x, 
                                               age_breaks = age_breaks_0_80_plus)) %>% 
    set_names(country_list)
  
  data_contact
}

save_conmat_as_csv <- function(matrix_list, path = "./", subfolder = FALSE) {
  
  # This function saves the contact matrices derived from
  # extrapolate_polymod() for a list of countries and
  # saves them to individual csv files.
  # Option to save to subfolders.
  
  for (country_name in names(matrix_list)) {
    country_matrices <- matrix_list[[country_name]]
    
    # Create subfolder for each country if subfolder = TRUE
    if (subfolder) {
      folder_location <- file.path(path, country_name)
      dir_create(folder_location, recurse = TRUE)
    } else {
      folder_location <- path
    }
    
    for (matrix_name in names(country_matrices)) {
      matrix_data <- country_matrices[[matrix_name]]
      file_name <- glue("{country_name}_{matrix_name}_2015.csv")
      file_path <- file.path(folder_location, file_name)
      write.csv(matrix_data, file_path, row.names = TRUE)
    }
  }
}
