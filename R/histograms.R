#' Create a histogram with the given data
#'
#' @param data_frame a dataframe that need to be preprocessed
#' @param xvar the column/ variable for the x-axis of the histogram
#' @param yvar the column/ variable for the y-axis of the histogram
#' @param title the title for the histogram
#' @param xlabel the label for the x-axis of the histogram
#' @return a histogram with the given data and arguments
#'
#' @examples make_histogram(fullData, num_href, is_popular, 
#'                         "Histogram for is popular against num_refs", 
#'                         "Number of links", "Number of shares")
#' 
#' 

suppressMessages(library(tidyverse))


make_histogram <- function(data_frame, xvar, yvar, hist_title, xlabel) {
  # checks if data_frame is a valid dataframe
  if (!is.data.frame(data_frame)) {
    stop("data_frame should be a data frame")
  }

  # checks if data_frame has at least 1 row
  if (nrow(data_frame) == 0) {
    stop("The data frame should not be empty")
  }

  # checks if any element in the result vector is FALSE (all should be TRUE since they are labels)
  strings <- c(xvar, yvar, hist_title, xlabel)
  is_string_result <- sapply(strings, is.character)

  if (any(!is_string_result)) {
    stop("At least one element in the vector is not a string.")
  }

  # checks if xvar and yvar are actual column names in data_frame
  if (!(xvar %in% names(data_frame))) {
    stop("xvar is not a valid column name in data_frame")
  }
  
  if (!(yvar %in% names(data_frame))) {
    stop("yvar is not a valid column name in data_frame")
  }

  xvar <- data_frame[[xvar]]
  yvar <- data_frame[[yvar]]

  histogram <- ggplot(data_frame, aes(x = xvar, fill = yvar)) +
    geom_histogram(color = "black", bins = 30) +
    labs(title = hist_title, 
        x = xlabel,
        fill = "Popular")

  return(histogram)
}

