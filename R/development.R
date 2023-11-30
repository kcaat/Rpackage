#before our presentation, send her our slides

#library(available)
library(devtools)
library(usethis)

#necessary libraries
library(here)
library(tidyverse)
library(table1)

#available("dummypack", browse = FALSE)
#name is available

#load fake dataset
data <- read.csv(here("data/randomdata.csv"))

### dummy vars with exclusive categories

data$AreaType1 <- as.logical(data$AreaType1)

rndr <- function(x, ...) {
  y <- render.default(x, ...)
  if (is.logical(x)) y[2] else y
}

tabledummy <- table1(~ AreaType1 + AreaType2 + AreaType3, data=data, render=rndr)
tabledummy

area_labels <- c("Urban", "Suburban", "Rural")

subset <- data %>%
  select(starts_with("AreaType"))

dummies <- colnames(subset)

label(data[, dummies]) <- area_labels

#colnames(data) <- label_list
data_labeled <- data %>%
  mutate(across(starts_with("AreaType"), label<-area_labels))

labeled_areas <- vector("list", length = length(area_labels))
for (i in seq_along(area_labels)) {
  labeled_areas[[i]] <- paste(area_labels[i], get(paste("area", i, sep = "")), sep = "_")
}

#normal labelling code
label(data$AreaType1) <- "Urban"

for (i in area_labels)

#function
dummycats <- function(data, prefix, label_list){

  #subset data based on dummy prefix
  subset <- data %>%
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

### multi-option dummy variables

#list of labels
aspect_names <- c("Health", "Education", "Transportation", "Social services", "Safety", "Diversity & inclusion", "Housing")

### function
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
