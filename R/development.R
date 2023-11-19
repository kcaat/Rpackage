
library(available)
library(devtools)
library(usethis)

available("dummypack", browse = FALSE)
#available

### create table1 for dummy variable categories
library(table1)

# turn into factor
data$dummy1
factor(data$dummy1,
       levels=c(0,1),
       labels=c(
         "No",
         "Yes"
       )
)

# turn into logical
data$dummy1 <- as.logical(data$dummy1)

#label for table
label(data$dummy1) <- "Discrim0 &mdash; n (%)"

#render to only show 1s
rndr <- function(x, ...) {
  y <- render.default(x, ...)
  if (is.logical(x)) y[2] else y
}

#use table1 to create frequency table
table1(~ dummy1, data=data, render=rndr)
