# conmat extension: All countries

This workflow extends the [`conmat`](https://github.com/idem-lab/conmat) package to generate synthetic contact matrices for all countries listed in the United Nations' World Population Prospects (2017).

## Step-by-step instructions

This section will explain each target object so you can run the analysis yourself.

This analysis uses a `targets` workflow. Refer to the `targets` [documentation](https://books.ropensci.org/targets/) for more information.

First we create the age-specific population data we would like to generate synthetic contact matrices for. 
In this instance, we obtain this population data using the `wpp_age()` function from the `socialmixr` package.

The next step sorts out issues unique to the WPP dataset.
In this instance, we manually rename the regions Hong Kong and Taiwan as well as remove observations labelled "Less developed regions, excluding China."
If this was not done manually, the next step will re-label these observations as "China," which is problematic for the subsequent steps of the analysis.

For users who are using their own data within this workflow, we recommend you explore and manually clean your data in this step.

The next step standardises the country names. 
The function `standardise_country_names()` relies on the `countryname()` function in the `countrycode` package. 
The argument `conversion_destination_code` defaults to English country names but can be changed; 
refer to the [documentation](https://vincentarelbundock.github.io/countrycode/#/man/codelist) or type `?codelist` for a list of available codes.
The converted, standardised country names are saved as a new variable in the existing data frame called `std_country_names`.

You can check the excluded names in the following step.
As the population data obtained from `wpp_age()` also includes global and regional population data, in addition to country-level population data, we would like to exclude these.
Names that do not match a country name is labelled as missing (`NA`) in the `std_country_names` variable and these values are returned in a data frame for manual checking.

The data frame of standardised country names are then split into lists.

You can then select which countries you would like to create synthetic contact matrices for in the `selection_of_countries` target object. 
Creating contact matrices for all 201 countries at once (in other words, running the worflow as-is) takes about 13 minutes.

The next two target objects `population_data` and `contact_matrices_data` uses the `as_conmat_population` and `extrapolate_polymod` functions from `conmat`. `population_data` is a converted `conmat` population data and `contact_matrices_data` are the synthetic contact matrices generated for our data. For more information on the two `conmat` functions above, please refer to the `conmat` package [documentation](https://idem-lab.github.io/conmat/dev/index.html).

If you would like to adjust the age limits for the synthetic contact matrices, this can be done by changing the `start_age` and `end_age` arguments in the `create_contact_matrices()` function within the `contact_matrices_data` target object.

The last target object `csv_output` saves these resulting contact matrices as csv files. 
The `path` argument allows you to specify where you would like to save these csv files. 
The `subfolder` argument, with its default value being `true`, allows you to save the five resulting contact matrices for each country in its own subdirectory. 
In other words, the five synthetic contact matrices generated (for the environments: all, home, other, school, and work) for one country--as an example, Algeria--is saved in its own subfolder labelled 'Algeria' within the path specified. 
If the `subfolder` argument were set to `false`, all contact matrices for all countries would be saved within the specified path without subdirectories; in other words, all csv files would be saved in the one folder.

To run the analysis using your own population data: open the `_targets.R` script in the main directory, make changes to refer to your own data, and run the workflow using `tar_make()`.

## Data sources

The age-specific population data that forms the basis for this analysis were derived from the `wpp_age` function in the [`socialmixr`](https://epiforecasts.io/socialmixr/) package, which uses data from the [`wpp2017`](https://cran.r-project.org/web/packages/wpp2017/index.html) package.

## Notes

The contact matrices created are transposed in comparison to those discussed by [Prem, Cook, and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697) and [Mossong et al. (2008)](https://doi.org/10.1371/journal.pmed.0050074). In other words, the rows are "age group to" and the columns are "age group from".

For more information on the `conmat` package, refer to its [documentation](https://idem-lab.github.io/conmat/dev/index.html).

For more information on targets workflows, refer to the `targets` [user manual](https://books.ropensci.org/targets/).
