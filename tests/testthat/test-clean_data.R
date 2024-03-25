library(testthat)
source("../../R/clean_data.R")

test_that("data_frame should be a dataframe", 
{expect_error(clean_data(list_wrong_type), "data.frame")
})



test_that("The data frame does not contain all the required columns: shares, num_hrefs, num_imgs, num_videos", 
{expect_error(clean_data(without_shares_df))
 expect_error(clean_data(without_num_hrefs_num_imgs_df))
})


test_that(" data_frame shouldn't be empty", 
{expect_error(clean_data(empty_df))})



test_that("`clean_data` should return a data frame, or data frame extension, 
whose values in the `is_popular` column is 0 when `shares` smaller than 1400, otherwise is 0",{
 expect_equivalent(clean_data(good_df),check_popular_value)
})

