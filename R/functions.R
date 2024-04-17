standardise_country_names <- function(data,
                                      column_name,
                                      destination = "country.name.en"
                                      ) {
  
  # Depends on the countrycode package.
  # This function takes country names from age-specific population data
  # and standardises the country names according to current UN standards
  # Uses fuzzy matching, so slightly-off names are also standardised. 
  # Subsequently, only the country names are selected.
  # Returns data frame with a new column called std_country.
  
  data$country_names <- countrycode::countryname(
    data[[column_name]],
    destination = destination,
    nomatch = NA,
    warn = TRUE
  )
  
  data_out <- data %>% 
    filter(!is.na(country_names)) %>% 
    select(country_names, lower.age.limit, year, population) %>% 
    rename(lower_age_limit = lower.age.limit)
  
  return(data_out)
}

create_population_data <- function(in_list_of_data){
  
  # This function takes the list of countries,
  # and plugs it into as_conmat_population()
  # to create the population data.
  
  population_data <- map(
    .x = in_list_of_data,
    .f = \(x) as_conmat_population(
      data = x,
      age = lower_age_limit, 
      population = population))
  
  return(population_data)
}

create_contact_matrices <- function(population_data,
                                    start_age = 0, 
                                    end_age = 80){
  
  # This function takes the population data
  # and subsequently uses extrapolate_polymod()
  # to derive the social contact matrices
  
  age_breaks_user_defined <- c(seq(start_age, end_age, by = 5), Inf)
  
  contact_data <- map(
    .x = population_data,
    .f = \(x) extrapolate_polymod(
      population = x, 
      age_breaks = age_breaks_user_defined
      )
    )
  
  return(contact_data)
}

save_conmat_as_csv <- function(matrix_list, 
                               path = "./", 
                               subfolder = FALSE) {
  
  # This function saves the contact matrices derived from
  # extrapolate_polymod() for a list of countries and
  # saves them to individual csv files.
  # Option to save to subfolders.
  
  for (country_name in names(matrix_list)) {
    country_matrices <- matrix_list[[country_name]]
    
    # Create subfolder for each country if subfolder = TRUE, else remain same
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

check_cm_equal <- function(file1, file2) {
  data1 <- read.csv(file1, stringsAsFactors = FALSE)
  data2 <- read.csv(file2, stringsAsFactors = FALSE)
  
  # Check if the data frames are equal
  if (identical(data1, data2)) {
    message("The contact matrices (csv files) are identical.")
  } else {
    stop("Warning! The contact matrices (csv files) are not identical.")
  }
}
