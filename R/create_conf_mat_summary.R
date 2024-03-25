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
create_conf_mat_summary <- function(TP, FP, FN, TN, output_directory) {
  # Ensure the 'readr' package is available
  if (!requireNamespace("readr", quietly = TRUE)) {
    stop("The 'readr' package is required but is not installed.")
  }
  
  # Calculate metrics with checks to prevent division by zero
  knn_precision <- ifelse((TP + FP) > 0, TP / (TP + FP), NA)
  knn_recall <- ifelse((TP + FN) > 0, TP / (TP + FN), NA)
  knn_accuracy <- (TP + TN) / (TP + FP + FN + TN)  # Accuracy can still be calculated normally
  
  # Create the summary data frame
  conf_mat_summary <- data.frame(
    Precision = round(knn_precision, 4),
    Recall = round(knn_recall, 4),
    Accuracy = round(knn_accuracy, 4),
    TP = TP,
    FP = FP,
    FN = FN,
    TN = TN
  )
  
  # Construct the full path for the CSV file
  csv_file_path <- file.path(output_directory, 'conf_mat_summary.csv')
  
  # Write the data frame to a CSV file
  readr::write_csv(conf_mat_summary, csv_file_path)
}
