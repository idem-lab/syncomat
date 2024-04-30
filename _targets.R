# Set-up ------------------------------

library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("conmat", 
               "socialmixr", 
               "countrycode",
               "tibble", 
               "readr", 
               "dplyr",
               "glue", 
               "fs",
               "purrr")
  )

# Set up a workspace when our code errors
tar_option_set(workspace_on_error = TRUE)

source("R/functions.R")

# Target objects ------------------------------

tar_plan(
  
  # Loads 2015 data from wpp_age() function
  # USER: If you would like to use your own data,
  #       add it in here.
  tar_target(
    in_data_wpp,
    wpp_age(years = 2015)
  ),
  
  # Clean unique issues in wpp_age() data
  tar_target(
    cleaned_wpp,
    in_data_wpp %>%
      mutate(country = case_when(
        
        # Renames the following, otherwise picked up as "China"
        country == "China, Hong Kong SAR" ~ "Hong Kong",
        country == "China, Taiwan province of China" ~ "Taiwan, Province of China",
        .default = country
      )) %>% 
      
      # The following is pesky; otherwise picked up as "China"
      filter(country != "Less developed regions, excluding China")
  ),
  
  # Standardise country names
  tar_target(
    standardised_wpp_data,
    standardise_country_names(
      cleaned_wpp,
      column_name = "country",
      conversion_destination_code = "country.name.en")
  ),
  
  # USER: check excluded region names if needed
  tar_target(
    excluded_names,
    standardised_wpp_data %>% 
      filter(is.na(std_country_names)) %>% 
      select(country) %>% 
      distinct(country)
  ),
  
  # Creates a list (required for input into the next workflow)
  tar_target(
    list_of_data,
    split(
      standardised_wpp_data, 
      standardised_wpp_data$std_country_names)
  ),
  
  # USER: In the following target object:
  #       Choose which countries you'd like to create 
  #       contact matrices for using the index
  #       (201 countries from wpp_age() data)
  tar_target(
    selection_of_countries,
    list_of_data[1:201]
  ),
  
  # Create population data
  tar_target(
    population_data, 
    create_population_data(selection_of_countries)
  ),
  
  # Create contact matrices
  tar_target(
    contact_matrices_data, 
    create_contact_matrices(
      population_data = population_data,
      start_age = 0,
      end_age = 80
    )
  ),
  
  # Save as csv files
  # USER: Change path and subfolder option here
  tar_target(
    csv_output,
    save_conmat_as_csv(
      matrix_list = contact_matrices_data, 
      path = "./output/240427 all countries output", 
      subfolder = TRUE
      ), 
    format = "file"
  )
  
)
