# Set-up ------------------------------

library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("conmat", 
               "socialmixr", 
               "mgcv",
               "tibble", 
               "readr", 
               "dplyr", 
               "ggplot2", 
               "patchwork", 
               "glue", 
               "fs",
               "purrr")
  )

# Set up a workspace when our code errors
tar_option_set(workspace_on_error = TRUE)

source("R/functions.R")

# Target objects ------------------------------

# To make dataset from wpp_age() only

tar_plan(
  
  # Extract all data from wpp_age()
  tar_target(wpp_data, wpp_age()),
  
  tar_file(
    all_countries_path,
    "./raw/all-countries.csv"
    ),
  
  tar_target(
    all_countries,
    read_csv(all_countries_path) %>% 
      select(country = name)
  ),
  
  # Create country_list
  tar_target(
    country_list, 
    create_country_list_from_wpp(wpp_data = wpp_data, 
                                 countries = all_countries)
    ),
  
  # USER SELECTION - In the following target:
  # Choose which countries you'd like to create 
  # contact matrices for using the index
  tar_target(
    selection_of_countries,
    country_list[1:3]
  ),
  
  # Create population data from list of countries
  tar_target(
    data_pop, 
    create_pop_data(selection_of_countries)
    ),
  
  # Create contact matrices
  tar_target(
    data_contact, 
    create_contact_matrices(
      data_pop = data_pop,
      country_list = selection_of_countries,
      start_age = 0,
      end_age = 80
    )
  ),
  
  # Save the csv files
  tar_target(
    csv_output,
    save_conmat_as_csv(
      matrix_list = data_contact, 
      path = "./output/240403 test", 
      subfolder = TRUE
      ), 
    format = "file")
             
  
)