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
               "purrr",
               "cli")
  )

tar_option_set(workspace_on_error = TRUE)

source("R/functions.R")

# Target objects ------------------------------

tar_plan(
  
  # USER: If you would like to use your own population data,
  #       add it in here instead of the 2015 WPP data.
  tar_target(
    in_data_wpp,
    wpp_age(years = 2015)
  ),
  
  # Clean issues unique to the wpp_age() data
  tar_target(
    cleaned_wpp,
    in_data_wpp %>%
      mutate(country = case_when(
        
        # Renames the following, otherwise picked up as "China"
        country == "China, Hong Kong SAR" ~ "Hong Kong",
        country == "China, Taiwan province of China" ~ "Taiwan, Province of China",
        .default = country
      )) %>% 
      
      # The following is otherwise picked up as "China"
      filter(country != "Less developed regions, excluding China")
  ),
  
  tar_target(
    standardised_wpp_data,
    standardise_country_names(
      cleaned_wpp,
      column_name = "country",
      conversion_destination_code = "iso3c")
  ),
  
  tar_target(
    excluded_names,
    standardised_wpp_data %>% 
      filter(is.na(std_country_names)) %>% 
      select(country) %>% 
      distinct(country)
  ),
  
  tar_target(
    list_of_data,
    split(
      standardised_wpp_data, 
      standardised_wpp_data$std_country_names)
  ),
  
  # Select the countries you would like to 
  # generate synthetic contact matrices for
  tar_target(
    selection_of_countries,
    list_of_data[1:200]
    # Or alternatively, use dplyr's filter function:
    # dplyr::filter(country %in% c("Australia", "New Zealand"))
  ),
  
  tar_target(
    population_data, 
    create_population_data(selection_of_countries)
  ),
  
  tar_target(
    contact_matrices_data, 
    create_contact_matrices(
      population_data = population_data,
      start_age = 0,
      end_age = 80
    )
  ),
  
  tar_target(
    csv_output,
    save_conmat_as_csv(
      matrix_list = contact_matrices_data, 
      path = "./output-contact-matrices", 
      subfolder = FALSE
      ), 
    format = "file"
  )
  
)
