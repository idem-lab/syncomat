# conmat extension: All countries

This workflow provides csv files of synthetic contact matrices generated for all countries listed in the United Nations' World Population Prospects (2017), using the [`conmat`](https://github.com/idem-lab/conmat) package.[^2] The `conmat` package is motivated by the contact matrices generated in [Prem, Cook, and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697).

## Download contact matrices

The contact matrices can be found in the folder `output-contact-matrices`.

Each csv file is named in the convention `{Country}_{Environment}_2015.csv`. For example, `AUS_work_2015.csv`. Country names are in ISO-3 format. The five environments for each country are all, home, school, work, and other.

## Recreate this analysis

To recreate this analysis, you would need to be familiar with the `targets` workflow.[^1]

Make any changes necessary in the `_targets.R` file, then run `tar_make()`. If you're unsure how to make your changes, the following **Methodology** section will explain each target object.

Without any changes, it will take approximately 13 minutes to run the entire process, which will generate contact matrices for 200 countries.

The packages needed for this workflow are listed in the `_targets.R` file, under the heading "Set-up."

## Methodology

1. Create the age-specific population data you would like to generate synthetic contact matrices for. In this instance, the population data was obtained using the `wpp_age()` function from the `socialmixr` package.

   If you would like to use your own age-specific population data, load your data as a target object here. Your data must have the following variables:
   
   - `country` for country name,
   - `year` for the year of survey,
   - `lower.age.limit` for the lower age limit of each age group, and
   - `population` for the size of each age group.

2. Clean the data. This step sorts out issues unique to the WPP dataset. In this instance, we manually rename the regions Hong Kong and Taiwan as well as remove observations labelled "Less developed regions, excluding China." If this was not done manually, the next step will re-label these observations as "China," which is problematic for the subsequent steps of the analysis.

   If you are using your own data within this workflow, we recommend you explore and manually clean your data in this step.

3. Standardise the country names. The function `standardise_country_names()` relies on the `countryname()` function in the `countrycode` package. The argument `conversion_destination_code` defaults to ISO-3 codes (`"iso3c"`) but can be changed to whatever you like.[^3] The converted, standardised country names are saved as a new variable in the existing data frame called `std_country_names`.

4. Check excluded region names. As the population data obtained from `wpp_age()` also includes global and regional population data in addition to country-level population data, we would like to exclude these. Names that do not match a country name are labelled as missing (`NA`) in the `std_country_names` variable. These values are returned in a data frame for manual checking.

   To obtain this data frame, use `tar_load(excluded_names)`.

4. Split the data frame of standardised country names into lists.

5. Select which countries you would like to create synthetic contact matrices for.

   `list_of_data[1:200]` returns all 200 countries in the WPP data. Change these numbers if you would only like a subset of this 200. 
   
   Alternatively, use `dplyr::filter()` if you have a list of country names you would like to filter.

6. `population_data` creates a converted `conmat` population data using the [`as_conmat_population()`](https://idem-lab.github.io/conmat/dev/reference/as_conmat_population.html) function from `conmat`.

6. `contact_matrices_data` generates synthetic contact matrices from our population data using the [`extrapolate_polymod()`](https://idem-lab.github.io/conmat/dev/reference/extrapolate_polymod.html) function from `conmat`. 
   
   If you would like to adjust the age limits for the synthetic contact matrices, this can be done by changing the `start_age` and `end_age` arguments in the `create_contact_matrices()` function. The default is 0 to 80+ years. If you would like to change it to 0 to 60+, you would change `end_age = 60`.

7. Save the generated synthetic contact matrices as csv files. 

   The `path` argument allows you to specify where you would like to save these csv files; change this if you would like to change the folder name. The default folder name is `output-contact-matrices`.
   
   The `subfolder` argument, if set to `TRUE`, allows you to save the five resulting contact matrices for each country in its own subdirectory. In other words, the five synthetic contact matrices generated (for the environments: all, home, other, school, and work) for one country--as an example, Australia--is saved in its own subfolder labelled 'AUS' within the path specified.
   
   If the `subfolder` argument were set to `FALSE`, all contact matrices for all countries would be saved within the specified path without subdirectories. In other words, all csv files would be saved in the one folder.

## Data sources

The age-specific population data that forms the basis for this analysis were derived from the [`wpp_age()`](https://epiforecasts.io/socialmixr/reference/wpp_age.html) function in the [`socialmixr`](https://epiforecasts.io/socialmixr/) package, which uses data from the [`wpp2017`](https://cran.r-project.org/web/packages/wpp2017/index.html) package.

## Notes

The contact matrices created are transposed in comparison to those discussed by [Prem, Cook, and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697) and [Mossong et al. (2008)](https://doi.org/10.1371/journal.pmed.0050074). In other words, the rows are "age group to" and the columns are "age group from".

[^2]: For more information on the `conmat` package, refer to its [documentation](https://idem-lab.github.io/conmat/dev/index.html).

[^1]: For more information on `targets` workflow, refer to the `targets` [user manual](https://books.ropensci.org/targets/).

[^3]: Refer to the `countrycodes` [documentation](https://vincentarelbundock.github.io/countrycode/#/man/codelist) or type `?codelist` for a list of available codes.