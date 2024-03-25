#' Create and Write a Summary of the Confusion Matrix to CSV
#'
#' This function calculates precision, recall, and accuracy from given
#' confusion matrix components (TP, FP, FN, TN) and writes the summary
#' into a CSV file.
#'
#' @param TP True Positives count.
#' @param FP False Positives count.
#' @param FN False Negatives count.
#' @param TN True Negatives count.
#' @param output_directory Directory to save the summary CSV file.
#'
#' @return The function saves a CSV file named 'conf_mat_summary.csv'
#' in the specified directory and does not return anything.
#' @export
#'
#' @examples
#' create_conf_mat_summary(50, 10, 5, 35, "data/")

