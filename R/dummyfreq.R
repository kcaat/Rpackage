#' Create frequency table for multi-option dummy variable
#'
#' @author Katherine Lu
#'
#' @param data your data frame
#' @param prefix prefix that identifies all dummy variables in one category
#' @param label_list optional: list of labels for each dummy level
#' @param title optional: title of Table 1
#'
#' @return table 1 displaying n (%) of each dummy variable level
#' @export
#'
#' @examples
#' library(dplyr)
#' library(table1)
#' category_names <- c("Health", "Education", "Transportation", "Social services", "Safety", "Diversity & inclusion", "Housing")
#' dummyfreq(data=randomsurvey, prefix="Aspect", label_list=category_names, title="Community aspects")

dummyfreq <- function(data, prefix, label_list, title){

  #subset data based on dummy prefix
  data <- data %>%
    dplyr::select(dplyr::starts_with(prefix))

  #rename variables based on labels list, if provided
  if (!missing(label_list)) {
    colnames(data) <- label_list
  }

  #add title if provided
  #if no title argument, use variable prefix
  if (missing(title)) {
    title1 <- paste(prefix, "n (%)")
  } else {
    title1 <- paste(title, "n (%)")
  }

  #turn dummy vars into logicals
  data[colnames(data)] <- lapply(data[colnames(data)], as.logical)

  #create render so that only YES is shown
  rndr <- function(x, ...) {
    y <- table1::render.default(x, ...)
    if (is.logical(x)) y[2] else y
  }

  #create table1
  return(table1::table1(~ ., data=data, caption=title1, render=rndr))
}
