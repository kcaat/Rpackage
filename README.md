# dummypack

-   Package for processing dummy variables
-   Required packages: dplyr, table1


### R installation instructions

``` r
install.packages("devtools")
library(devtools)
devtools::install_github("kcaat/dummypack")
library(dummypack)
```

## Function: dummyvar

Combines dummy variables into one variable, outputting your data frame
with new combined variable 

### Arguments: `dummyvar(data, prefix, label_list, varname)` 

* **data:** your data frame
* **prefix:** prefix that identifies a group of dummy variables (all dummy variables should start with the same prefix that is unique to
one group)
* **label_list (OPTIONAL):** list of variable categories
    - if specified, will rename dummy variables in order of list
    - if not provided, will keep dummy variable names
* **varname (OPTIONAL):** label for combined variable
    - if specified, will label combined variable
    - if not provided, will not label

### Example

-   Example data where AreaType1/2/3 are dummy variables for a multiple
    choice survey question "What type of area do you live in?"
-   `dummyvar` adds the new variable 'combined' to the data frame
- NOTE: if this function is used multiple times for different sets of dummy variables, will need to rename 'combined' variable or it will be overwritten each time

``` r
area_labels <- c("urban", "suburban", "rural")
dummyvar(data=surveydata, prefix="AreaType", label_list=area_labels)
```

| AreaType1 | AreaType2 | AreaType3 | combined  |
|-----------|-----------|-----------|-----------|
| 0         | 1         | 0         | surburban |
| 1         | 0         | 0         | urban     |
| 1         | 0         | 0         | urban     |
| 0         | 0         | 1         | rural     |
| ...       | ...       | ...       | ...       |

## Function: dummyfreq

### Arguments: `dummyvar(data, prefix, label_list, title)`

-   **data:** your data frame
-   **prefix:** prefix that identifies a group of dummy variables (all
    dummy variables should start with the same prefix that is unique to
    one group)
-   **label_list (OPTIONAL):** list of variable categories
    -   if specified, will rename dummy variables in order of list
    -   if not provided, will keep dummy variable names
-   **title (OPTIONAL):** title for output table
    -   if specified, will use title for the outputted table 1
    -   if not provided, will use prefix as title

### Example

-   Example data for a survey question where respondents can select
    multiple options, "What do you think are the top 3 most important
    aspects for your community?"
-   Aspect1/2/3/4/5/6/7 are dummy variables that cannot be combined
    because they are not exclusive
-   `dummyfreq` produces a frequency table showing n (%) of each
    category
- NOTE: frequency table does not include missing values

| Aspect1 | Aspect2 | Aspect3 | Aspect4 | Aspect5 | Aspect6 | Aspect7 |
|---------|---------|---------|---------|---------|---------|---------|
| 0       | 1       | 0       | 1       | 1       | 0       | 0       |
| 1       | 0       | 0       | 1       | 0       | 0       | 1       |
| 1       | 0       | 1       | 0       | 0       | 0       | 1       |
| 0       | 1       | 1       | 0       | 0       | 0       | 1       |
| ...     | ...     | ...     | ...     | ...     | ...     | ...     |

``` r
category_names <- c("Health", "Education", "Transportation", "Social services", "Safety", "Diversity & inclusion", "Housing")
dummyfreq(data=randomsurvey, prefix="Aspect", label_list=category_names, title="Community aspects")
```
