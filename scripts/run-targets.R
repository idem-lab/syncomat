tar_manifest(fields = all_of("command"))

tar_visnetwork()

# Initially took 13m that led to error
# Made targets for 1:3   (3)  - pipeline took 15.75s (5.25s each)
# Made targets for 4:10  (7)  - pipeline took 33.05s (4.7s each)
# Made targets for 11:20 (10) - pipeline took 46.75s (4.675s each)
# Made targets for 21:50 (30) - pipeline took 2.625m (5.25s each)
# Made targets for 51:80 (30) - pipeline took 2.264m (4.53s each)
# Made targets for 81:130 (50) - pipeline took 4.01m (4.81s each)
# Made targets for 131:183 (50) - pipeline took 3.98m (4.77s each)

# Meeting Notes ---------------------------

#%% 28.03.24 --------------------------------

tar_make(selection_of_countries) # Only runs it up until that point (w dependencies)

tar_read(country_list)

tar_load(all_countries)

# The above is equivalent to:
all_countries <- tar_read(all_countries)


# In the _targets.R file, the following
#     sets up a workspace when our code errors
# Refer to https://books.ropensci.org/targets/debugging.html#workspaces
tar_option_set(workspace_on_error = TRUE)
