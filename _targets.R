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
  
  # Loads data from wpp_age() function
  tar_target(
    in_data_wpp,
    wpp_age(years = 2015)
  ),
  
  # Clean unique issues in wpp_age() data
  tar_target(
    cleaned_wpp,
    in_data_wpp %>% 
      mutate(country = case_when(
        country == "China, Hong Kong SAR" ~ "Hong Kong",
        country == "China, Taiwan province of China" ~ "Taiwan, Province of China",
        .default = country
      ))
  ),
  
  # Standardises the country names
  tar_target(
    standardised_wpp_data,
    standardise_country_names(
      cleaned_wpp,
      column_name = "country")),
  
  # Creates a list (required for input into the next workflow)
  tar_target(
    list_of_data,
    split(
      standardised_wpp_data, 
      standardised_wpp_data$country_names)
  ),
  
  # USER SELECTION - In the following target:
  # Choose which countries you'd like to create 
  # contact matrices for using the index
  tar_target(
    selection_of_countries,
    list_of_data[1:201]
  ),
  
  # Create conmat's population data
  tar_target(
    population_data, 
    create_population_data(selection_of_countries)
    ),
  
  # Create contact matrices
  tar_target(
    data_contact_matrices, 
    create_contact_matrices(
      population_data = population_data,
      start_age = 0,
      end_age = 80
    )
  ),
  
  # Save the csv files
  tar_target(
    csv_output,
    save_conmat_as_csv(
      matrix_list = data_contact_matrices, 
      path = "./output/240417 all countries output", 
      subfolder = TRUE
      ), 
    format = "file")
             
)