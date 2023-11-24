#library(available)
library(devtools)
library(usethis)

#necessary libraries
library(here)
library(tidyverse)
library(table1)

available("dummypack", browse = FALSE)
#available

#load fake dataset
data <- read.csv(here("data/randomdata.csv"))

### dummy vars with exclusive categories

### multi-option dummy variables



# turn into factors, and then logicals
cleandata <- function(dataset, statistic){
  #Use the select() function in the dplyr package (part of tidyverse) subset the data to have   only the variables Country.Name, X2000 – X2019.
  dataset <- dataset %>% select(Country.Name, X2000:X2019)

  #remove prefix X from column names
  colnames(dataset)<-gsub("X","",colnames(dataset))

  #Use the pivot_longer() function to convert the data set from wide to long format.
  dataset <- pivot_longer(dataset,
                          cols=c('2000':'2019'),
                          names_to = "Year", values_to = statistic,
                          values_drop_na = FALSE,
                          names_transform = list(Year = as.numeric))
}

#subset dummy variables based on name
data_aspect <- data %>%
  select(starts_with("Aspect"))

print(sapply(data, class))

#put names into list
aspect_dummies <- colnames(data_aspect)

data_aspect[aspect_dummies] <- lapply(data_aspect[aspect_dummies], factor)
data_aspect[aspect_dummies] <- lapply(data_aspect[aspect_dummies], as.logical)

data_aspect$Aspect1 <- as.logical(data_aspect$Aspect1)
table(data_aspect$Aspect2)

#label for table
label(data$dummy1) <- "Discrim0 &mdash; n (%)"

#render to only show 1s
rndr <- function(x, ...) {
  y <- render.default(x, ...)
  if (is.logical(x)) y[2] else y
}

title1 <- "n (%)"
title2 <- sprintf(data$Aspect1, "n (%)")
title2 <- cat(data$Aspect1, "n (%)")

#use table1 to create frequency table
table1(~ ., data=data_aspect, caption=title1, render=rndr)

#list of labels
aspect_names <- c("Health", "Education", "Transportation", "Social services", "Safety", "Diversity & inclusion", "Housing")

### make function
dummyfreq <- function(data, prefix, label_list){

  #subset data based on dummy prefix
  data <- data %>%
    select(starts_with(prefix))

  #rename variables based on labels list, if provided
  if (!is.null(labels)) {
    colnames(data) <- label_list
  }

  #turn dummy vars into logicals
  data[colnames(data)] <- lapply(data[colnames(data)], as.logical)

  #create render so that only YES is shown
  rndr <- function(x, ...) {
    y <- render.default(x, ...)
    if (is.logical(x)) y[2] else y
  }

  #create title using prefix
  title <- paste(prefix, "n (%)")

  #create table1
  return(table1(~ ., data=data, caption=title, render=rndr))
}

dummyfreq(data, "Aspect", aspect_names)
