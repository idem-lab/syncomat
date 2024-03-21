# Set-up ------------------------------

library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("conmat", "socialmixr", "mgcv",
               "tibble", "readr", "dplyr", "ggplot2", "patchwork",
               "purrr")
)

source("R/functions.R")

# Target objects ------------------------------

tar_plan(
  wpp_data = wpp_age(),
  
)