# dummypack
* Package for processing dummy variables
* Required packages: dplyr, table1
### R installation instructions
```r
install.packages("devtools")
library(devtools)
devtools::install_github("kcaat/dummypack")
library(dummypack)
```
## Function: dummyvar
Combines dummy variables into one variable, outputting your data frame with new combined variable
### Arguments: dummyvar(data, prefix, label_list, varname)
* **data:** your data frame
* **prefix:** prefix that identifies a group of dummy variables (all dummy variables should start with the same prefix that is unique to one group)
* **label_list (OPTIONAL):** list of variable categories
  + if specified, will rename dummy variables in order of list
  + if not provided, will keep dummy variable names
* **varname (OPTIONAL):** label for combined variable
  + if specified, will label combined variable
  + if not provided, will not label

### Example
Example data
```{r}
surveydata <- read.csv(here("data/randomsurvey.csv"))
data1 <- surveydata %>%
    select(starts_with("AreaType"))
head(data1, n = 10)
```

## Function: dummyfreq
### Arguments: dummyvar(data, prefix, label_list, title)
* **data:** your data frame
* **prefix:** prefix that identifies a group of dummy variables (all dummy variables should start with the same prefix that is unique to one group)
* **label_list (OPTIONAL):** list of variable categories
  + if specified, will rename dummy variables in order of list
  + if not provided, will keep dummy variable names
* **title (OPTIONAL):** title for output table
  + if specified, will use title for the outputted table 1
  + if not provided, will use prefix as title
