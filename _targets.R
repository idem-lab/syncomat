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
               "furrr",
               "cli",
               "visNetwork")
  )

tar_option_set(workspace_on_error = TRUE)

source("R/functions.R")

# Target objects ------------------------------

tar_plan(
  
  # USER: If you would like to use your own population data,
  #       add it in here instead of the 2015 WPP data.
  tar_target(
    in_data_perth,
    abs_age_lga("Perth (C)")
  ),

  tar_target(
    contact_matrices_data, 
    extrapolate_polymod(
      population = in_data_perth, 
      age_breaks = c(seq(0, 80, by = 5), Inf)
    )
  ),
  
  tar_target(
    csv_output,
    save_conmat_as_csv(
      matrix_list = contact_matrices_data, 
      path = "./test-run-perth", 
      subfolder = FALSE
      ), 
    format = "file"
  )
  
)
