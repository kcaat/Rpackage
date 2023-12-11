#' Combine dummy variables with exclusive levels
#'
#' @author Katherine Lu
#'
#' @param data your data frame
#' @param prefix prefix that identifies all dummy variables in one category
#' @param label_list optional: list of labels for each dummy level
#' @param varname optional: label for combined variable
#'
#' @return data frame with new combined variable
#' @export
#'
#' @examples
#' library(dplyr)
#' library(table1)
#' area_labels <- c("Urban", "Suburban", "Rural")
#' data2 <- dummyvar(data=randomsurvey, prefix="AreaType", label_list=area_labels, varname="Area Types")
#' table1(~ combined, data=data2) #see new variable in a table1

dummyvar <- function(data, prefix, label_list, varname){

  #subset data based on dummy vars prefix
  subset <- data %>%
    dplyr::select(dplyr::starts_with(prefix))

  #rename variables based on labels list, if provided
  if (!missing(label_list)) {
    colnames(subset) <- label_list
  }

  #create combined variable in original dataframe, using subset
  #finds column with max value (1)
  data$combined <- colnames(subset)[max.col(subset)]

  #factor the combined variable
  data$combined <- factor(data$combined)

  #label the combined variable, if varname provided
  #if not provided, use prefix
  if (missing(varname)) {
    table1::label(data$combined) <- prefix
  } else {
    table1::label(data$combined) <- varname
  }

  #return dataframe, with new combined variable
  return(data)
}
