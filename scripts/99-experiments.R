library(conmat)

# Getting Started steps -----

polymod_contact_data <- get_polymod_contact_data(setting = "work")
polymod_survey_data <- get_polymod_population()

contact_model <- fit_single_contact_model(
  contact_data = polymod_contact_data,
  population = polymod_survey_data
)

# Measuring the time it takes --------

time.results <- rbenchmark(
  contact_model <- fit_single_contact_model(
    contact_data = polymod_contact_data,
    population = polymod_survey_data
  )
)
# Using tictoc: 83.71s