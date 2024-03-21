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

list(
  tar_target(data, data.frame(x = sample.int(100), y = sample.int(100))),
  tar_target(data_summary, summarize_data(data)) # Call your custom functions.
)

tar_plan()