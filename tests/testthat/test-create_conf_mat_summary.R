library(testthat)
source("../../R/create_conf_mat_summary.R")

test_that("Function creates CSV correctly with valid input", {
  temp_dir <- tempdir()
  create_conf_mat_summary(50, 10, 5, 35, temp_dir)
  file_path <- file.path(temp_dir, "conf_mat_summary.csv")
  expect_true(file.exists(file_path))
})

test_that("Function handles division by zero correctly", {
  temp_dir <- tempdir()
  create_conf_mat_summary(0, 0, 0, 0, temp_dir)
  file_path <- file.path(temp_dir, "conf_mat_summary.csv")
  expect_true(file.exists(file_path))
})

test_that("conf matrix with ideal scenario", {
  temp_dir <- tempdir()
  create_conf_mat_summary(ideal_scenario$TP, ideal_scenario$FP, ideal_scenario$FN, ideal_scenario$TN, temp_dir)
  output <- read.csv(file.path(temp_dir, 'conf_mat_summary.csv'), stringsAsFactors = FALSE)
  
  expected_metrics <- calculate_metrics(ideal_scenario)
  
  expect_equal(as.numeric(output$Precision), as.numeric(expected_metrics$Precision))
  expect_equal(as.numeric(output$Recall), as.numeric(expected_metrics$Recall))
  expect_equal(as.numeric(output$Accuracy), as.numeric(expected_metrics$Accuracy))
})

test_that("conf matrix with no positive", {
  temp_dir <- tempdir()
  create_conf_mat_summary(no_positives_scenario$TP, no_positives_scenario$FP, no_positives_scenario$FN, no_positives_scenario$TN, temp_dir)
  output <- read.csv(file.path(temp_dir, 'conf_mat_summary.csv'), stringsAsFactors = FALSE)
  
  expected_metrics <- calculate_metrics(no_positives_scenario)
  
  expect_equal(as.numeric(output$Precision), as.numeric(expected_metrics$Precision))
  expect_equal(as.numeric(output$Recall), as.numeric(expected_metrics$Recall))
  expect_equal(as.numeric(output$Accuracy), as.numeric(expected_metrics$Accuracy))
})

test_that("conf matrix with erfect predictions", {
  temp_dir <- tempdir()
  create_conf_mat_summary(perfect_predictions$TP, perfect_predictions$FP, perfect_predictions$FN, perfect_predictions$TN, temp_dir)
  output <- read.csv(file.path(temp_dir, 'conf_mat_summary.csv'), stringsAsFactors = FALSE)
  
  expected_metrics <- calculate_metrics(perfect_predictions)
  
  expect_equal(as.numeric(output$Precision), as.numeric(expected_metrics$Precision))
  expect_equal(as.numeric(output$Recall), as.numeric(expected_metrics$Recall))
  expect_equal(as.numeric(output$Accuracy), as.numeric(expected_metrics$Accuracy))
})

test_that("conf matrix with all incorrect", {
  temp_dir <- tempdir()
  create_conf_mat_summary(all_incorrect$TP, all_incorrect$FP, all_incorrect$FN, all_incorrect$TN, temp_dir)
  output <- read.csv(file.path(temp_dir, 'conf_mat_summary.csv'), stringsAsFactors = FALSE)
  
  expected_metrics <- calculate_metrics(all_incorrect)
  
  expect_equal(as.numeric(output$Precision), as.numeric(expected_metrics$Precision))
  expect_equal(as.numeric(output$Recall), as.numeric(expected_metrics$Recall))
  expect_equal(as.numeric(output$Accuracy), as.numeric(expected_metrics$Accuracy))
})