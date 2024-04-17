# Set-up ------------------------------

library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("conmat", 
               "socialmixr", 
               "countrycode",
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
  
  tar_target(
    in_data_wpp,
    wpp_age(years = 2015)
  ),
  
  tar_target(
    standardised_wpp_data,
    standardise_country_names(
      in_data_wpp,
      column_name = "country")),
  
  # USER SELECTION - In the following target:
  # Choose which countries you'd like to create 
  # contact matrices for using the index
  tar_target(
    selection_of_countries,
    standardised_wpp_data[1:3,]
  ),
  
  # Create population data from list of countries
  tar_target(
    population_data, 
    create_population_data(selection_of_countries)
    ),
  
  # Create contact matrices
  tar_target(
    data_contact_matrices, 
    create_contact_matrices(
      data_pop = population_data,
      country_list = selection_of_countries,
      start_age = 0,
      end_age = 80
    )
  ),
  
  # Save the csv files
  tar_target(
    csv_output,
    save_conmat_as_csv(
      matrix_list = data_contact_matrices, 
      path = "./output/240403 test", 
      subfolder = TRUE
      ), 
    format = "file")
             
)