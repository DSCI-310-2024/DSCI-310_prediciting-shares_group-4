#' Clean the data and return a dataframe with the colums: shares, num_hrefs, num_imgs, num_videos is_popular
#'
#' @param data a dataframe that need to be preprocessed
#'
#' @return a clean dataframe with 5 columns
#' @export
#'
#' @examples preprocess_data(fulldata)
clean_data <- function(data_frame){
  if (!is.data.frame(data_frame)) {
    stop("`data_frame` should be a data frame or data frame extension (e.g. a tibble)")
  }


  required_columns <- c("shares", "num_hrefs", "num_imgs", "num_videos")
  if (!all(required_columns %in% names(data_frame))) {
    stop("The data frame does not contain all the required columns: shares, num_hrefs, num_imgs, num_videos")
  }  

  if (nrow(data_frame) == 0) {
    stop("The data frame should not be empty")
  }

  clean_data_frame <- data_frame |>
    dplyr::select(all_of(required_columns)) |>
    dplyr::mutate(is_popular = ifelse(shares < 1400, 0, 1),
                  is_popular = as.factor(is_popular))
  
  return(clean_data_frame)
   
}

