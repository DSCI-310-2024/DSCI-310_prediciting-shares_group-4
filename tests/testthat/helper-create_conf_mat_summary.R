# Helper variables for different test scenarios

# Ideal scenario
ideal_scenario <- list(TP = 50, FP = 10, FN = 5, TN = 35)

# No positives
no_positives_scenario <- list(TP = 0, FP = 0, FN = 50, TN = 50)

# Perfect predictions
perfect_predictions_scenario <- list(TP = 100, FP = 0, FN = 0, TN = 100)

# All incorrect
all_incorrect_scenario <- list(TP = 0, FP = 100, FN = 100, TN = 0)

# Function to calculate expected metrics based on the confusion matrix components
calculate_metrics <- function(cm) {
  # Handle division by zero for precision and recall
  precision <- ifelse((cm$TP + cm$FP) > 0, cm$TP / (cm$TP + cm$FP), NA)
  recall <- ifelse((cm$TP + cm$FN) > 0, cm$TP / (cm$TP + cm$FN), NA)
  accuracy <- (cm$TP + cm$TN) / (cm$TP + cm$FP + cm$FN + cm$TN)

  # Return a list of the calculated metrics
  return(list(Precision = precision, Recall = recall, Accuracy = accuracy))
}

# Calculate and update scenarios with their expected metrics
ideal_scenario <- calculate_metrics(ideal_scenario)
no_positives <- calculate_metrics(no_positives_scenario)
perfect_predictions <- calculate_metrics(perfect_predictions_scenario)
all_incorrect <- calculate_metrics(all_incorrect_scenario)
