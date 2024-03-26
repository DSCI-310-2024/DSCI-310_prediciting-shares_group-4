library(testthat)
source("../../R/histograms.R")

test_that("data_frame should be a dataframe", 
{expect_error(make_histogram(list_wrong_type, "num_imgs", "shares", 
"Histogram of shares against number of images", "Number of Images"))
})

test_that("data_frame should not be empty", 
{expect_error(make_histogram(empty_df, "num_imgs", "shares", 
"Histogram of shares against number of images", "Number of Images"))
})

test_that("xlab should be a string", 
{expect_error(make_histogram(list_wrong_type, "num_imgs", "shares", 
"Histogram of shares against number of images", num_imgs))
})

test_that("title should be a string", 
{expect_error(make_histogram(list_wrong_type, "num_imgs", "shares", 
shares, "Number of Images"))
})

test_that("num_imgs should be a string", 
{expect_error(make_histogram(list_wrong_type, num_imgs, "shares", 
shares, "Number of Images"))
})

test_that("shares should be a string", 
{expect_error(make_histogram(list_wrong_type, "num_imgs", shares, 
shares, "Number of Images"))
})

test_that("xvar should be a valid column in data_frame", 
{expect_error(make_histogram(list_wrong_type, "num_images", "shares", 
"Histogram of shares against number of images", "Number of Images"))
})

test_that("yvar should be a valid column in data_frame", 
{expect_error(make_histogram(list_wrong_type, "num_imgs", "num_images", 
"Histogram of shares against number of images", "Number of Images"))
})