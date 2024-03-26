# Set-up ------------------------------

library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("conmat", "socialmixr", "mgcv",
               "tibble", "readr", "dplyr", "ggplot2", 
               "patchwork", "glue", "fs",
               "purrr")
)

source("R/functions.R")

# Target objects ------------------------------

# To make dataset from wpp_age() only

tar_plan(
  
  # Extract all data from wpp_age()
  tar_target(wpp_data, wpp_age()),
  
  # Create country_list
  tar_target(country_list, create_country_list_from_wpp(wpp_data)),
  
  # Choose which countries you'd like to extract data for
  tar_target(test_country_list, country_list[15:18]),
  
  # Create population data from list of countries
  tar_target(data_pop, create_pop_data(test_country_list)),
  
  # Create contact matrices
  tar_target(data_contact, 
             create_contact_matrices(data_pop, test_country_list, 0, 80)),
  
  # Save the csv files
  tar_target(csv_output,
             save_conmat_as_csv(data_contact, path = "./output/", subfolder = FALSE), 
             format = "file")
  
)