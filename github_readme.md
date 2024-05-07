# Synthetic contact matrices for 200 UN countries

This workflow provides csv files of synthetic contact matrices generated for all countries listed in the United Nations' World Population Prospects (2017), using the [`conmat`](https://github.com/idem-lab/conmat) package.[^readme-1] The `conmat` package is motivated by the contact matrices generated in [Prem, Cook, and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697).

[^readme-1]: For more information on the `conmat` package, refer to its [documentation](https://idem-lab.github.io/conmat/dev/index.html).

## Download contact matrices

The contact matrices can be found in the folder `output-contact-matrices`.

Each csv file is named in the convention `{Country}_{Environment}_2015.csv`; for example, `AUS_work_2015.csv`. Country names are in ISO-3 format. The five environments for each country are: home, school, work, other, and all.

Here is how you would load the contact matrices in R:

``` r
library(readr)
url <- "https://raw.githubusercontent.com/chitrams/conmat-testing/main/output-contact-matrices/AUS_work_2015.csv"
aus_work_cm <- read_csv(url)
aus_work_cm
```

The following is a synthetic contact matrix for Australia in a work setting, with the columns being "age group from" and the rows being "age group to."

|          | [0,5)                | [5,10)               | [10,15)             | [15,20)             | [20,25)             | [25,30)            | [30,35)            | [35,40)            | [40,45)            | [45,50)            | [50,55)            | [55,60)            | [60,65)             | [65,70)             | [70,75)             | [75,80)              | [80,Inf)             |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| [0,5)    | 0.00309595154233613  | 0.00502261168085602  | 0.00376556999284528 | 0.00391592320056183 | 0.00787400782193361 | 0.0171668729994751 | 0.0283165259082213 | 0.0343337162346202 | 0.0354210543175982 | 0.0333788708447245 | 0.0257280282378574 | 0.014198118234185  | 0.00584005923861962 | 0.0022529590787013  | 0.0010015276305536  | 0.00054121617315857  | 0.000404760617574312 |
| [5,10)   | 0.00484838849126762  | 0.0110901591793185   | 0.00852720640042657 | 0.00695996256355932 | 0.0146622241486835  | 0.0277766571460361 | 0.0375652298569594 | 0.0399262117412703 | 0.0398810438088269 | 0.0391429964736457 | 0.0335015342342383 | 0.0219260440365096 | 0.0110712055840766  | 0.00509047926687923 | 0.00252518846060569 | 0.00148693438264483  | 0.00114398132964528  |
| [10,15)  | 0.00355770957703246  | 0.00834600679983973  | 0.025146038361287   | 0.0214704323591649  | 0.0292900516633499  | 0.0402283530308997 | 0.0444560978875896 | 0.0430436532601351 | 0.0423635675088831 | 0.0425711246297876 | 0.0379776806236486 | 0.0268420258164438 | 0.0156049406568242  | 0.00862186445848016 | 0.00496029600389873 | 0.00314182841005715  | 0.00242047722195962  |
| [15,20)  | 0.00381340216496076  | 0.00702130012449676  | 0.0221299006763587  | 0.0960160682363726  | 0.121459565250399   | 0.120329663754706  | 0.115114482685541  | 0.105795981312442  | 0.102730126613212  | 0.103073714584696  | 0.0914079565047987 | 0.0638108267088552 | 0.0376974635429777  | 0.0224362038843856  | 0.0147000840269533  | 0.0102560438675843   | 0.00779316643907177  |
| [20,25)  | 0.00825274281048862  | 0.0159196866136529   | 0.0324924783609173  | 0.130724126431096   | 0.370744635522802   | 0.371723075331624  | 0.324805006170388  | 0.287284309214541  | 0.269901457319017  | 0.262399077553394  | 0.226019220317758  | 0.152976091319122  | 0.0882154929864732  | 0.0528160473754577  | 0.037311061064345   | 0.0291980333251872   | 0.0239649104743028   |
| [25,30)  | 0.0190355883068703   | 0.0319070959386263   | 0.0472136518870645  | 0.137015395730821   | 0.393271216617821   | 0.632718366295093  | 0.580883300240892  | 0.495722809807313  | 0.446181699255561  | 0.41569322694152   | 0.346688728174742  | 0.229654444687688  | 0.13026096839259    | 0.0769564009029645  | 0.0553982368711708  | 0.0469588297232646   | 0.0464483666728317   |
| [30,35)  | 0.0314349340118315   | 0.0432007040452149   | 0.0522353074247522  | 0.131227273771484   | 0.344027237928344   | 0.581549069616474  | 0.698186584867633  | 0.613240046944533  | 0.52718011830211   | 0.471534802592715  | 0.382781357698905  | 0.250391969433053  | 0.141156121155963   | 0.0823748003014158  | 0.058543122906556   | 0.0508978765320689   | 0.0644459098325226   |
| [35,40)  | 0.0367924615810716   | 0.0443229163165374   | 0.0488210805692962  | 0.116420312277163   | 0.29372943446626    | 0.479073143213879  | 0.591964900132588  | 0.660446950866942  | 0.583709642766118  | 0.507669029982555  | 0.405133307586371  | 0.262109147650448  | 0.146159132846477   | 0.0838760716699353  | 0.0583813595242249  | 0.0506521139866599   | 0.0835409857119002   |
| [40,45)  | 0.0371076701685875   | 0.0432813612157248   | 0.0469737206862167  | 0.110515090624022   | 0.269777026943462   | 0.421540054804583  | 0.497494912190075  | 0.570638461297262  | 0.623326576281272  | 0.561277010312715  | 0.44289445529055   | 0.281406457684815  | 0.152732648318341   | 0.0851748715113848  | 0.058365110864942   | 0.0513000649498746   | 0.110661610308804    |
| [45,50)  | 0.0343353297047097   | 0.0417115031131104   | 0.0463494874570218  | 0.108877731959484   | 0.257530941700536   | 0.385626987881771  | 0.436928878326585  | 0.487317738033359  | 0.551118045117484  | 0.595461626635263  | 0.486267111867825  | 0.299683591521944  | 0.156265906120663   | 0.0843901338471657  | 0.0577778893512692  | 0.0529904798253496   | 0.138479429848121    |
| [50,55)  | 0.0257699279615137   | 0.0347619065606903   | 0.0402620023955063  | 0.0940182704822014  | 0.215997937476504   | 0.313163626229774  | 0.345370226917269  | 0.378674986690729  | 0.423452538081395  | 0.473491314958717  | 0.476076069909775  | 0.301189980715633  | 0.151272291693616   | 0.0803042700204638  | 0.055874282057694   | 0.053453981179572    | 0.133830528754303    |
| [55,60)  | 0.0134059740531678   | 0.0214466793536733   | 0.0268252085748366  | 0.0618704841224613  | 0.137812520941092   | 0.195554282846203  | 0.212968513119128  | 0.230946684897302  | 0.253629310849096  | 0.275081237810581  | 0.283923543108113  | 0.225248919223178  | 0.11858314963419    | 0.0634077176482425  | 0.0446256659126004  | 0.0418504573739863   | 0.0745749031629352   |
| [60,65)  | 0.00496990581969204  | 0.00976018416648242  | 0.0140557252574462  | 0.0329431097681916  | 0.0716264295571273  | 0.099970093828954  | 0.108207668338272  | 0.116069692143362  | 0.124068229579905  | 0.129278278437146  | 0.1285238101619    | 0.10687750372016   | 0.0760295011213076  | 0.0451398498345022  | 0.0302944811114863  | 0.0244866012122518   | 0.0245313761720671   |
| [65,70)  | 0.0016369617421376   | 0.00383156404804108  | 0.00663050563941073 | 0.0167400272604313  | 0.0366141244603919  | 0.0504260401334492 | 0.0539146781981963 | 0.056870268207242  | 0.0590737457230523 | 0.0596083802325593 | 0.0582528481107342 | 0.0487932516423876 | 0.0385402413034085  | 0.0385487378505003  | 0.0262950221444964  | 0.0156005436958869   | 0.007985698391749    |
| [70,75)  | 0.000578139965926653 | 0.00151006639872419  | 0.00303066464408937 | 0.00871387712157296 | 0.020549685895853   | 0.0288397101253607 | 0.0304420124659884 | 0.0314489557724988 | 0.0321603797504664 | 0.0324236683945444 | 0.03220144142003   | 0.0272826895342603 | 0.0205495667019006  | 0.0208909587796724  | 0.0199280283395739  | 0.00853496366699048  | 0.00245924037677138  |
| [75,80)  | 0.000238316375664918 | 0.00067827703625181  | 0.00146428567411642 | 0.00463750665758727 | 0.0122668837672807  | 0.0186477000649578 | 0.020188785780987  | 0.0208133823865011 | 0.0215624860040216 | 0.0226835691846472 | 0.0234993838324875 | 0.0195171204291436 | 0.0126701197985271  | 0.00945447956763302 | 0.0065105059295444  | 0.00111107617862216  | 0.000155457260874669 |
| [80,Inf) | 0.000255122708921483 | 0.000746967996470783 | 0.00161477530644689 | 0.00504413122474107 | 0.0144119985472998  | 0.0264025701642525 | 0.0365909465170745 | 0.049137429235987  | 0.0665802849664553 | 0.0848528734045254 | 0.0842169212734414 | 0.0497824171668458 | 0.0181694538603644  | 0.00692753207535981 | 0.00268523185856183 | 0.000222524974374735 | 2.55985214544983e-07 |

## Recreate this analysis

To recreate this analysis, you would need to be familiar with the `targets` workflow.[^readme-2]

[^readme-2]: For more information on `targets` workflow, refer to the `targets` [user manual](https://books.ropensci.org/targets/).

Make any changes necessary in the `_targets.R` file, then run `tar_make()`. If you're unsure how to make your changes, the following **Methodology** section will explain each target object.

Without any changes, it will take approximately 13 minutes to run the entire process, which will generate contact matrices for 200 countries.

The packages needed for this workflow are listed in the `_targets.R` file, under the heading "Set-up."

## Methodology

Here we provide the relevant components of the code in `_targets.R` and describe what these parts of the code are doing.

``` r
```

1.  Create the age-specific population data you would like to generate synthetic contact matrices for. In this instance, the population data was obtained using the `wpp_age()` function from the `socialmixr` package.

    If you would like to use your own age-specific population data, load your data as a target object here. Your data must have the following variables:

    -   `country` for country name,
    -   `year` for the year of survey,
    -   `lower.age.limit` for the lower age limit of each age group, and
    -   `population` for the size of each age group.

2.  Clean the data. This step sorts out issues unique to the WPP dataset. In this instance, we manually rename the regions Hong Kong and Taiwan as well as remove observations labelled "Less developed regions, excluding China." If this was not done manually, the next step will re-label these observations as "China," which is problematic for the subsequent steps of the analysis.

    If you are using your own data within this workflow, we recommend you explore and manually clean your data in this step.

3.  Standardise the country names. The function `standardise_country_names()` relies on the `countryname()` function in the `countrycode` package. The argument `conversion_destination_code` defaults to ISO-3 codes (`"iso3c"`) but can be changed to whatever you like.[^readme-3] The converted, standardised country names are saved as a new variable in the existing data frame called `std_country_names`.

4.  Check excluded region names. As the population data obtained from `wpp_age()` also includes global and regional population data in addition to country-level population data, we would like to exclude these. Names that do not match a country name are labelled as missing (`NA`) in the `std_country_names` variable. These values are returned in a data frame for manual checking.

    To obtain this data frame, use `tar_load(excluded_names)`.

5.  Split the data frame of standardised country names into lists.

6.  Select which countries you would like to create synthetic contact matrices for.

    `list_of_data[1:200]` returns all 200 countries in the WPP data. Change these numbers if you would only like a subset of this 200.

    Alternatively, use `dplyr::filter()` if you have a list of country names you would like to filter.

7.  `population_data` creates a converted `conmat` population data using the [`as_conmat_population()`](https://idem-lab.github.io/conmat/dev/reference/as_conmat_population.html) function from `conmat`.

8.  `contact_matrices_data` generates synthetic contact matrices from our population data using the [`extrapolate_polymod()`](https://idem-lab.github.io/conmat/dev/reference/extrapolate_polymod.html) function from `conmat`.

    If you would like to adjust the age limits for the synthetic contact matrices, this can be done by changing the `start_age` and `end_age` arguments in the `create_contact_matrices()` function. The default is 0 to 80+ years. If you would like to change it to 0 to 60+, you would change `end_age = 60`.

9.  Save the generated synthetic contact matrices as csv files.

    The `path` argument allows you to specify where you would like to save these csv files; change this if you would like to change the folder name. The default folder name is `output-contact-matrices`.

    The `subfolder` argument, if set to `TRUE`, allows you to save the five resulting contact matrices for each country in its own subdirectory. In other words, the five synthetic contact matrices generated (for the environments: all, home, other, school, and work) for one country--as an example, Australia--is saved in its own subfolder labelled 'AUS' within the path specified.

    If the `subfolder` argument were set to `FALSE`, all contact matrices for all countries would be saved within the specified path without subdirectories. In other words, all csv files would be saved in the one folder.

[^readme-3]: Refer to the `countrycodes` [documentation](https://vincentarelbundock.github.io/countrycode/#/man/codelist) or type `?codelist` for a list of available codes.

## Data sources

The age-specific population data that forms the basis for this analysis were derived from the [`wpp_age()`](https://epiforecasts.io/socialmixr/reference/wpp_age.html) function in the [`socialmixr`](https://epiforecasts.io/socialmixr/) package, which uses data from the [`wpp2017`](https://cran.r-project.org/web/packages/wpp2017/index.html) package.

## Notes

The contact matrices created are transposed in comparison to those discussed by [Prem, Cook, and Jit (2017)](https://doi.org/10.1371/journal.pcbi.1005697) and [Mossong et al. (2008)](https://doi.org/10.1371/journal.pmed.0050074). In other words, the rows are "age group to" and the columns are "age group from".
