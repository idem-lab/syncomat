# conmat extension: All countries

This workflow uses the [`conmat` package](https://github.com/idem-lab/conmat) to generate synthetic contact matrices for all countries listed in the United Nations' World Population Prospects (2017).

## Workflow

This analysis uses a [`targets` workflow](https://books.ropensci.org/targets/). This section will run through each target object.

We first obtain the age-specific population data we would like to generate synthetic contact matrices for. In our instance we get this data from the `wpp_age` function from the `socialmixr` package.

The next step standardises the country names. A point to note is that some country names have changed as this data is from the 2017 edition of the World Population Prospects. In this instance we use an existing list of standardised country names saved as a csv file in the project directory.

We then select data for which the country names are in the standardised list. The population data obtained from the `wpp_age` function includes global and regional levels in addition to the country level. As we are only interested in country-level contact matrices, in this step we only select countries.

The user can then select which countries they would like to create synthetic contact matrices for in the `selection_of_countries` target object. Creating contact matrices for all 183 countries at once (in other words, running the worflow as-is) takes about 13 minutes.

The next two target objects `data_pop` and `data_contact` uses the `as_conmat_population` and `extrapolate_polymod` functions from `conmat`. `data_pop` is a converted `conmat` population data and `data_contact` is the synthetic contact matrix generated for our data. For more information on the two `conmat` functions above, please refer to the `conmat` package documentation.

If you would like to adjust the age limits for the synthetic contact matrices, this can be done by changing the `start_age` and `end_age` arguments in the `data_contact` target object.

The last target object `csv_output` saves these resulting contact matrices as csv files. The `path` argument allows you to specify where you would like to save these csv files. The `subfolder` argument, with its default value being `true`, allows you to save the five resulting contact matrices for each country in its own subdirectory. In other words, the five synthetic contact matrices generated (for all, home, other, school, and work environments) for one country--as an example, Algeria--is saved in its own subfolder labelled 'Algeria' within the path specified. If the `subfolder` argument was set to `false`, all contact matrices for all countries would be saved within the specified path without subdirectories.

To run the analysis using your own population data: open the `_targets.R` script in the main directory, make changes to refer to your own data, and run the workflow using `tar_make()`.

## Data sources

The age-specific population data that forms the basis for this analysis were derived from the `wpp_age` function in the [`socialmixr` package](https://epiforecasts.io/socialmixr/), which uses data from the [`wpp2017` package](https://cran.r-project.org/web/packages/wpp2017/index.html).

## Notes

The contact matrices created are transposed in comparison to those discussed by [Prem, Cook, and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697) and [Mossong et al. (2008)](https://doi.org/10.1371/journal.pmed.0050074). In other words, the rows are "age group to" and the columns are "age group from".

For more information on the `conmat` package, refer to its [documentation](https://idem-lab.github.io/conmat/dev/index.html).

For more information on targets workflows, refer to the [`targets` user manual](https://books.ropensci.org/targets/).
