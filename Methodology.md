
## Methodology

Here we provide the relevant code from `_targets.R` and describe what
they do.

1.  Create the age-specific population data you would like to generate
    synthetic contact matrices for.

    ``` r
    tar_target(
        in_data_wpp,
        wpp_age(years = 2015)
    ),
    ```

    If you would like to use your own age-specific population data, load
    your data as a target object here using a function such as
    `read_csv()`. Your data must have the following variables:

    - `country` for country name,
    - `year` for the year of survey,
    - `lower.age.limit` for the lower age limit of each age group, and
    - `population` for the size of each age group.

    In this instance, we use the `wpp_age()` function from the
    `socialmixr` package to obtain our population data. The data is
    saved in the target object `in_data_wpp`.

2.  Clean the data.

    ``` r
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
    ```

    This step sorts out issues unique to the WPP dataset. In this
    instance, we manually rename the regions Hong Kong and Taiwan as
    well as remove observations labelled “Less developed regions,
    excluding China.” If this was not done manually, the next step will
    re-label these observations as “China,” which is problematic for the
    subsequent steps of the analysis.

    If you are using your own data within this workflow, we recommend
    you explore and manually clean your data in this step.

3.  Standardise the country names.

    ``` r
    tar_target(
        standardised_wpp_data,
        standardise_country_names(
          cleaned_wpp,
          column_name = "country",
          conversion_destination_code = "iso3c")
    ),
    ```

    The function `standardise_country_names()` relies on the
    `countryname()` function in the `countrycode` package. The argument
    `conversion_destination_code` defaults to ISO-3 codes (`"iso3c"`)
    but can be changed to whatever you like.[^1] The converted,
    standardised country names are saved as a new variable in the
    existing data frame called `std_country_names`.

4.  Check excluded region names.

    ``` r
    tar_target(
        excluded_names,
        standardised_wpp_data %>% 
          filter(is.na(std_country_names)) %>% 
          select(country) %>% 
          distinct(country)
    ),
    ```

    As the population data obtained from `wpp_age()` also includes
    global and regional population data in addition to country-level
    population data, we would like to exclude these. Names that do not
    match a country name are labelled as missing (`NA`) in the
    `std_country_names` variable. These values are returned in a data
    frame for manual checking.

    To obtain this data frame, use `tar_load(excluded_names)`.

5.  Split the data frame of standardised country names into lists.

    ``` r
    tar_target(
        list_of_data,
        split(
          standardised_wpp_data, 
          standardised_wpp_data$std_country_names)
    ),
    ```

6.  Select which countries you would like to create synthetic contact
    matrices for.

    ``` r
    tar_target(
        selection_of_countries,
        list_of_data[1:200]
    ),
    ```

    `list_of_data[1:200]` returns all 200 countries in the WPP data.
    Change these numbers if you would only like a subset of this 200.

    Alternatively, use `dplyr::filter()` if you have a list of country
    names you would like to filter.

7.  Convert our data to a `conmat` population data.

    ``` r
    tar_target(
        population_data, 
        create_population_data(selection_of_countries)
    ),
    ```

    The function `create_population_data()` uses the
    [`as_conmat_population()`](https://idem-lab.github.io/conmat/dev/reference/as_conmat_population.html)
    function from `conmat`.

8.  Generate synthetic contact matrices from our population data.

    ``` r
    tar_target(
        contact_matrices_data, 
        create_contact_matrices(
          population_data = population_data,
          start_age = 0,
          end_age = 80
        )
    ),
    ```

    If you would like to adjust the age limits for the synthetic contact
    matrices, this can be done by changing the `start_age` and `end_age`
    arguments in the `create_contact_matrices()` function. The default
    is 0 to 80+ years. If you would like to change it to 0 to 60+, you
    would change `end_age = 60`.

    The `create_contact_matrices()` function uses the
    [`extrapolate_polymod()`](https://idem-lab.github.io/conmat/dev/reference/extrapolate_polymod.html)
    function from `conmat`.

9.  Save the generated synthetic contact matrices as csv files.

    ``` r
    tar_target(
        csv_output,
        save_conmat_as_csv(
          matrix_list = contact_matrices_data, 
          path = "./output-contact-matrices", 
          subfolder = FALSE
          ), 
        format = "file"
    ),
    ```

    The `path` argument allows you to specify where you would like to
    save these csv files; change this if you would like to change where
    the files should be saved. The folder specified in `path` must
    already exist.

    The `subfolder` argument defaults to `FALSE`, which means the
    generated contact matrices for all countries would be saved within
    the specified path without subdirectories. In other words, all csv
    files would be saved in the one folder.

    Alternatively, if the `subfolder` argument were set to `TRUE`, the
    five resulting contact matrices for each country are saved in its
    own subdirectory. In other words, the five synthetic contact
    matrices generated (for the environments: all, home, other, school,
    and work) for one country–as an example, Australia–is saved in its
    own subfolder labelled ‘AUS’ within the path specified.

[^1]: Refer to the `countrycodes`
    [documentation](https://vincentarelbundock.github.io/countrycode/#/man/codelist)
    or type `?codelist` for a list of available codes.
