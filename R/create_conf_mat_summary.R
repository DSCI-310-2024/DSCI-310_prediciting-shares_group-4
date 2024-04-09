#' Create and Write a Summary of the Confusion Matrix to CSV
#'
#' This function calculates precision, recall, and accuracy from given
#' confusion matrix components (True Positives, False Positives, 
#' False Negatives, True Negatives). It writes these metrics, along with 
#' the confusion matrix components, into a CSV file.
#'
#' @param TP Integer, count of True Positives.
#' @param FP Integer, count of False Positives.
#' @param FN Integer, count of False Negatives.
#' @param TN Integer, count of True Negatives.
#' @param output_directory String, path to the directory where the 
#' 'conf_mat_summary.csv' file will be saved.
#' @return NONE
#' @examples
#' # Example usage:
#' create_conf_mat_summary(TP = 50, FP = 10, FN = 5, TN = 35, 
#' output_directory = "/path/to/save")
#' @export
create_conf_mat_summary <- function(TP, FP, FN, TN, output_directory) {
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