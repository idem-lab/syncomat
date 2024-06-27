
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Synthetic contact matrices for 200 countries

<!-- badges: start -->

[![DOI](https://zenodo.org/badge/770713133.svg)](https://zenodo.org/doi/10.5281/zenodo.11365942)
<!-- badges: end -->

This analysis pipeline produces csv files of synthetic contact matrices
generated for all countries listed in the United Nations’ World
Population Prospects (2017), using the
[`conmat`](https://github.com/idem-lab/conmat) package.[^1] The `conmat`
package is motivated by the contact matrices generated in [Prem, Cook,
and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697).

These instructions will assist you in downloading the csv files for
synthetic contact matrices, and to modify the analysis pipeline to suit
your own needs.

## Download synthetic contact matrices

You can download the synthetic contact matrices by navigating to our
[Zenodo repository](https://zenodo.org/records/11365943) and downloading
the zip file. The contact matrices can be found in the folder
**output-contact-matrices**.

Each csv file is named in the convention
`{Country}_{Environment}_2015.csv`; for example, `AUS_work_2015.csv`.
Country names are in ISO-3 format. The five environments for each
country are: home, school, work, other, and all.

Alternatively, if you would like to load specific contact matrices, here
is how you would do so for Australia in all settings:

``` r
library(readr)
url <- "https://raw.githubusercontent.com/idem-lab/syncomat/main/output-contact-matrices/AUS_all_2015.csv"
aus_all_cm <- read_csv(url)
```

The following is how the synthetic contact matrix looks for Australia in
all settings, with the columns being “age group from” and the rows being
“age group to.”

| age_groups |  \[0,5) | \[5,10) | \[10,15) | \[15,20) | \[20,25) | \[25,30) | \[30,35) | \[35,40) | \[40,45) | \[45,50) | \[50,55) | \[55,60) | \[60,65) | \[65,70) | \[70,75) | \[75,80) | \[80,Inf) |
|:-----------|--------:|--------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|---------:|----------:|
| \[0,5)     | 2.36549 | 1.32146 |  0.47311 |  0.29575 |  0.40005 |  0.77449 |  1.15301 |  0.99993 |  0.64134 |  0.47867 |  0.44268 |  0.41760 |  0.35185 |  0.26851 |  0.19701 |  0.13537 |   0.07686 |
| \[5,10)    | 1.27674 | 7.34953 |  1.66447 |  0.41945 |  0.30169 |  0.48904 |  0.91914 |  1.13686 |  0.84775 |  0.57294 |  0.47211 |  0.40883 |  0.36431 |  0.32358 |  0.26286 |  0.18962 |   0.11482 |
| \[10,15)   | 0.44699 | 1.63060 | 10.87195 |  1.76465 |  0.48154 |  0.39025 |  0.57920 |  0.90744 |  0.98157 |  0.72667 |  0.51018 |  0.35212 |  0.25293 |  0.22886 |  0.20394 |  0.15588 |   0.09758 |
| \[15,20)   | 0.28800 | 0.42315 |  1.81674 |  9.51635 |  1.74482 |  0.68813 |  0.57022 |  0.68927 |  0.92875 |  0.96830 |  0.69633 |  0.39610 |  0.22885 |  0.18520 |  0.17954 |  0.15649 |   0.11044 |
| \[20,25)   | 0.41929 | 0.32756 |  0.53419 |  1.87586 |  4.95907 |  1.74664 |  0.97801 |  0.79992 |  0.85797 |  1.06005 |  1.03984 |  0.66555 |  0.34331 |  0.22024 |  0.19820 |  0.18753 |   0.15496 |
| \[25,30)   | 0.85879 | 0.56176 |  0.45801 |  0.78355 |  1.84767 |  3.01242 |  1.71204 |  1.09817 |  0.91736 |  0.96623 |  1.09704 |  0.96923 |  0.58925 |  0.32092 |  0.22601 |  0.19945 |   0.18568 |
| \[30,35)   | 1.27998 | 1.05702 |  0.68055 |  0.65003 |  1.03589 |  1.71400 |  2.39046 |  1.54667 |  1.05167 |  0.91530 |  0.91991 |  0.94739 |  0.80838 |  0.50495 |  0.28419 |  0.19238 |   0.18528 |
| \[35,40)   | 1.07154 | 1.26205 |  1.02924 |  0.75849 |  0.81787 |  1.06129 |  1.49302 |  2.01722 |  1.37952 |  0.99688 |  0.84227 |  0.76306 |  0.75673 |  0.67159 |  0.42916 |  0.22866 |   0.18398 |
| \[40,45)   | 0.67188 | 0.92003 |  1.08839 |  0.99913 |  0.85758 |  0.86669 |  0.99245 |  1.34863 |  1.75816 |  1.26520 |  0.89163 |  0.66054 |  0.56228 |  0.60097 |  0.55999 |  0.33882 |   0.21542 |
| \[45,50)   | 0.49238 | 0.61054 |  0.79116 |  1.02282 |  1.04038 |  0.89635 |  0.84813 |  0.95692 |  1.24230 |  1.60706 |  1.14430 |  0.69300 |  0.47216 |  0.43510 |  0.49951 |  0.45012 |   0.30138 |
| \[50,55)   | 0.44340 | 0.48987 |  0.54087 |  0.71622 |  0.99373 |  0.99096 |  0.83001 |  0.78726 |  0.85249 |  1.11424 |  1.51131 |  0.97152 |  0.54348 |  0.39952 |  0.39560 |  0.45260 |   0.42315 |
| \[55,60)   | 0.39430 | 0.39989 |  0.35189 |  0.38405 |  0.59958 |  0.82532 |  0.80580 |  0.67234 |  0.59534 |  0.63611 |  0.91582 |  1.30405 |  0.80135 |  0.48014 |  0.39168 |  0.39196 |   0.46427 |
| \[60,65)   | 0.29942 | 0.32117 |  0.22782 |  0.19999 |  0.27875 |  0.45223 |  0.61969 |  0.60094 |  0.45676 |  0.39061 |  0.46175 |  0.72225 |  1.07536 |  0.70064 |  0.46088 |  0.35168 |   0.35169 |
| \[65,70)   | 0.19510 | 0.24355 |  0.17600 |  0.13818 |  0.15268 |  0.21028 |  0.33049 |  0.45536 |  0.41681 |  0.30733 |  0.28981 |  0.36947 |  0.59820 |  0.98187 |  0.65803 |  0.34134 |   0.22572 |
| \[70,75)   | 0.11373 | 0.15719 |  0.12460 |  0.10643 |  0.10916 |  0.11766 |  0.14778 |  0.23118 |  0.30857 |  0.28031 |  0.22799 |  0.23946 |  0.31263 |  0.52279 |  0.84829 |  0.43245 |   0.19277 |
| \[75,80)   | 0.05961 | 0.08650 |  0.07265 |  0.07076 |  0.07879 |  0.07920 |  0.07631 |  0.09396 |  0.14241 |  0.19268 |  0.19897 |  0.18279 |  0.18197 |  0.20686 |  0.32988 |  0.46024 |   0.18492 |
| \[80,Inf)  | 0.04845 | 0.07497 |  0.06510 |  0.07148 |  0.09319 |  0.10554 |  0.10520 |  0.10821 |  0.12961 |  0.18467 |  0.26628 |  0.30992 |  0.26048 |  0.19581 |  0.21048 |  0.26470 |   0.18688 |

Each cell is the expected number of people that an individual will have
contact with per day. In the contact matrix above, the number 2.36549 in
the first column and first row indicates that we expect a 0-5 year old
to be in contact with two other 0-5 year olds per day. The number
1.27998 in the first column, seventh row (30-35 age group) indicates
that a 0-5 year old is, on average, in contact with one 30-35 year old
per day.

## Running the analysis pipeline

To run this analysis pipeline, you would need to be familiar with the
`targets` workflow.[^2] This pipeline also utilises `renv`.[^3]

First, download the zip file of this analysis pipeline from our [Zenodo
repository](https://zenodo.org/records/11365943). Open the project in a
new RStudio session.

Once you’ve opened the project in a new RStudio session, you will be
prompted to run `renv::restore()`. Run `renv::restore()` to install the
packages used in this analysis to your workspace. If you then come
across issues, run `renv::status()`. Also run `?renv::status()` for
advice on resolving these issues.

Open the `_targets.R` file, and run all lines of code under the
**Set-up** section to load the R packages required for this pipeline.
You can then run `tar_make()` to run the entire pipeline.

If you need more information about the pipeline, the
[**Methodology**](https://github.com/idem-lab/syncomat/blob/main/Methodology.md)
page will explain each target object and how you can modify each object
to suit your own analysis needs.

This pipeline takes approximately 13 minutes[^4] to run, which will
generate contact matrices for 200 countries.

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

[^2]: For information on the `targets` workflow, refer to the `targets`
    [user manual](https://books.ropensci.org/targets/).

[^3]: For information on how `renv` works, refer to the Introduction to
    `renv`
    [vignette](https://rstudio.github.io/renv/articles/renv.html). For a
    quick overview, refer to its
    [website](https://rstudio.github.io/renv/index.html).

[^4]: This pipeline took 13 minutes to run on a computer equipped with
    an Intel Core i7-8565U and 16 GB of RAM running a 64-bit version of
    Windows.
