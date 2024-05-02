
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Synthetic contact matrices for 200 countries

<!-- badges: start -->
<!-- badges: end -->

This analysis pipeline provides csv files of synthetic contact matrices
generated for all countries listed in the United Nations’ World
Population Prospects (2017), using the
[`conmat`](https://github.com/idem-lab/conmat) package.[^1] The `conmat`
package is motivated by the contact matrices generated in [Prem, Cook,
and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697).

## Download contact matrices

The contact matrices can be found in the folder
`output-contact-matrices`.

Each csv file is named in the convention
`{Country}_{Environment}_2015.csv`; for example, `AUS_work_2015.csv`.
Country names are in ISO-3 format. The five environments for each
country are: home, school, work, other, and all.

Here is how you would load the contact matrices in R:

``` r
library(readr)
url <- "https://raw.githubusercontent.com/chitrams/conmat-testing/main/output-contact-matrices/AUS_work_2015.csv"
aus_work_cm <- read_csv(url)
```

The following is a synthetic contact matrix for Australia in a work
setting, with the columns being “age group from” and the rows being “age
group to.”

| age_groups |  \[0,5) | \[5,10) | \[10,15) | \[15,20) | \[20,25) | \[25,30) | \[30,35) | \[35,40) | \[40,45) | \[45,50) | \[50,55) | \[55,60) | \[60,65) | \[65,70) | \[70,75) | \[75,80) | \[80,Inf) |
|:-----------|--------:|--------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|----------:|
| \[0,5)     | 0.00310 | 0.00502 |  0.00377 |  0.00392 |  0.00787 |  0.01717 |  0.02832 |  0.03433 |  0.03542 |  0.03338 |  0.02573 |  0.01420 |  0.00584 |  0.00225 |  0.00100 |  0.00054 |   0.00040 |
| \[5,10)    | 0.00485 | 0.01109 |  0.00853 |  0.00696 |  0.01466 |  0.02778 |  0.03757 |  0.03993 |  0.03988 |  0.03914 |  0.03350 |  0.02193 |  0.01107 |  0.00509 |  0.00253 |  0.00149 |   0.00114 |
| \[10,15)   | 0.00356 | 0.00835 |  0.02515 |  0.02147 |  0.02929 |  0.04023 |  0.04446 |  0.04304 |  0.04236 |  0.04257 |  0.03798 |  0.02684 |  0.01560 |  0.00862 |  0.00496 |  0.00314 |   0.00242 |
| \[15,20)   | 0.00381 | 0.00702 |  0.02213 |  0.09602 |  0.12146 |  0.12033 |  0.11511 |  0.10580 |  0.10273 |  0.10307 |  0.09141 |  0.06381 |  0.03770 |  0.02244 |  0.01470 |  0.01026 |   0.00779 |
| \[20,25)   | 0.00825 | 0.01592 |  0.03249 |  0.13072 |  0.37074 |  0.37172 |  0.32481 |  0.28728 |  0.26990 |  0.26240 |  0.22602 |  0.15298 |  0.08822 |  0.05282 |  0.03731 |  0.02920 |   0.02396 |
| \[25,30)   | 0.01904 | 0.03191 |  0.04721 |  0.13702 |  0.39327 |  0.63272 |  0.58088 |  0.49572 |  0.44618 |  0.41569 |  0.34669 |  0.22965 |  0.13026 |  0.07696 |  0.05540 |  0.04696 |   0.04645 |
| \[30,35)   | 0.03143 | 0.04320 |  0.05224 |  0.13123 |  0.34403 |  0.58155 |  0.69819 |  0.61324 |  0.52718 |  0.47153 |  0.38278 |  0.25039 |  0.14116 |  0.08237 |  0.05854 |  0.05090 |   0.06445 |
| \[35,40)   | 0.03679 | 0.04432 |  0.04882 |  0.11642 |  0.29373 |  0.47907 |  0.59196 |  0.66045 |  0.58371 |  0.50767 |  0.40513 |  0.26211 |  0.14616 |  0.08388 |  0.05838 |  0.05065 |   0.08354 |
| \[40,45)   | 0.03711 | 0.04328 |  0.04697 |  0.11052 |  0.26978 |  0.42154 |  0.49749 |  0.57064 |  0.62333 |  0.56128 |  0.44289 |  0.28141 |  0.15273 |  0.08517 |  0.05837 |  0.05130 |   0.11066 |
| \[45,50)   | 0.03434 | 0.04171 |  0.04635 |  0.10888 |  0.25753 |  0.38563 |  0.43693 |  0.48732 |  0.55112 |  0.59546 |  0.48627 |  0.29968 |  0.15627 |  0.08439 |  0.05778 |  0.05299 |   0.13848 |
| \[50,55)   | 0.02577 | 0.03476 |  0.04026 |  0.09402 |  0.21600 |  0.31316 |  0.34537 |  0.37867 |  0.42345 |  0.47349 |  0.47608 |  0.30119 |  0.15127 |  0.08030 |  0.05587 |  0.05345 |   0.13383 |
| \[55,60)   | 0.01341 | 0.02145 |  0.02683 |  0.06187 |  0.13781 |  0.19555 |  0.21297 |  0.23095 |  0.25363 |  0.27508 |  0.28392 |  0.22525 |  0.11858 |  0.06341 |  0.04463 |  0.04185 |   0.07457 |
| \[60,65)   | 0.00497 | 0.00976 |  0.01406 |  0.03294 |  0.07163 |  0.09997 |  0.10821 |  0.11607 |  0.12407 |  0.12928 |  0.12852 |  0.10688 |  0.07603 |  0.04514 |  0.03029 |  0.02449 |   0.02453 |
| \[65,70)   | 0.00164 | 0.00383 |  0.00663 |  0.01674 |  0.03661 |  0.05043 |  0.05391 |  0.05687 |  0.05907 |  0.05961 |  0.05825 |  0.04879 |  0.03854 |  0.03855 |  0.02630 |  0.01560 |   0.00799 |
| \[70,75)   | 0.00058 | 0.00151 |  0.00303 |  0.00871 |  0.02055 |  0.02884 |  0.03044 |  0.03145 |  0.03216 |  0.03242 |  0.03220 |  0.02728 |  0.02055 |  0.02089 |  0.01993 |  0.00853 |   0.00246 |
| \[75,80)   | 0.00024 | 0.00068 |  0.00146 |  0.00464 |  0.01227 |  0.01865 |  0.02019 |  0.02081 |  0.02156 |  0.02268 |  0.02350 |  0.01952 |  0.01267 |  0.00945 |  0.00651 |  0.00111 |   0.00016 |
| \[80,Inf)  | 0.00026 | 0.00075 |  0.00161 |  0.00504 |  0.01441 |  0.02640 |  0.03659 |  0.04914 |  0.06658 |  0.08485 |  0.08422 |  0.04978 |  0.01817 |  0.00693 |  0.00269 |  0.00022 |   0.00000 |

## Recreate this analysis

To recreate this analysis, you would need to be familiar with the
`targets` workflow.[^2]

Make any changes necessary in the `_targets.R` file, then run
`tar_make()`. If you’re unsure how to make your changes, the following
**Methodology** section will explain each target object.

Without any changes, it will take approximately 13 minutes[^3] to run
the entire process, which will generate contact matrices for 200
countries.

The packages needed for this workflow are listed in the `_targets.R`
file, under the heading “Set-up.”

## Methodology

Here we provide the relevant code from `_targets.R` and describe what
they do.

1.  Create the age-specific population data you would like to generate
    synthetic contact matrices for. In this instance, the population
    data was obtained using the `wpp_age()` function from the
    `socialmixr` package. The data is saved in the target object
    `in_data_wpp`.

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
    but can be changed to whatever you like.[^4] The converted,
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

7.  `population_data` is a converted `conmat` population data using the
    [`as_conmat_population()`](https://idem-lab.github.io/conmat/dev/reference/as_conmat_population.html)
    function from `conmat`.

    ``` r
    tar_target(
        population_data, 
        create_population_data(selection_of_countries)
    ),
    ```

8.  Generate synthetic contact matrices from our population data using
    the
    [`extrapolate_polymod()`](https://idem-lab.github.io/conmat/dev/reference/extrapolate_polymod.html)
    function from `conmat`.

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
    save these csv files; change this if you would like to change the
    folder name. The default folder name is `output-contact-matrices`
    within the project directory.

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

## Data sources

The age-specific population data that forms the basis for this analysis
were derived from the
[`wpp_age()`](https://epiforecasts.io/socialmixr/reference/wpp_age.html)
function in the [`socialmixr`](https://epiforecasts.io/socialmixr/)
package, which uses data from the
[`wpp2017`](https://cran.r-project.org/web/packages/wpp2017/index.html)
package.

## Notes

The contact matrices created are transposed in comparison to those
discussed by [Prem, Cook, and Jit
(2017)](https://doi.org/10.1371/journal.pcbi.1005697) and [Mossong et
al. (2008)](https://doi.org/10.1371/journal.pmed.0050074). In other
words, the rows are “age group to” and the columns are “age group from”.

[^1]: For more information on the `conmat` package, refer to its
    [documentation](https://idem-lab.github.io/conmat/dev/index.html).

[^2]: For more information on `targets` workflow, refer to the `targets`
    [user manual](https://books.ropensci.org/targets/).

[^3]: This pipeline took 13 minutes to run on a computer equipped with
    an Intel:registered: Core:tm: i7-8565U and 16 GB of RAM running a
    64-bit version of Windows.

[^4]: Refer to the `countrycodes`
    [documentation](https://vincentarelbundock.github.io/countrycode/#/man/codelist)
    or type `?codelist` for a list of available codes.
