# documentation comments
"This script uses the KNN model to predict number of shares for testing data.

Usage: src/knn.R --workflow=<workflow> --output=<output>

Options:
--workflow=<workflow> knn workflow
--output=<output> Destination folder Ex: src/
" -> doc

# import libraries/packages
suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))
suppressMessages(library(kknn))
suppressMessages(library(tidymodels))
suppressWarnings(library(dsci310utils))

# parse/define command line arguments here
opt <- docopt(doc)

# define main function

main <- function(output, workflow){
    # Convert the output directory argument to a string
    output1 <- toString(output)

    # Read a serialized workflow object from a given file path
    workflow <- readRDS(toString(workflow))

    # Read the testing data CSV
    articles_testing <- suppressMessages(read_csv('data/testing_data.csv'))
    articles_testing <- articles_testing |> mutate(is_popular = as.factor(is_popular))

    # predicting number of shares for testing data
    articles_predict <- predict(workflow, articles_testing) |>
    bind_cols(articles_testing)

    # Calculate the accuracy of the predictions, filtering the results to only include accuracy metric
    articles_accuracy <- articles_predict |>
    metrics(truth = is_popular, estimate = .pred_class) |>
    filter(.metric == "accuracy")

    # Save the accuracy results to a CSV file 
    write_csv(articles_accuracy, paste('data/', 'model_accuracy.csv', sep = ''))

    # Generate a confusion matrix for the predictions
    confusion_matrix <- articles_predict |>
    conf_mat(truth = is_popular, estimate = .pred_class)

    # Save the confusion matrix object as an RDS file in the specified output directory
    saveRDS(confusion_matrix, paste(output1, 'objects/conf_mat.rds', sep = ''))

    # Extract true positive, false positive, false negative, and true negative counts from the confusion matrix
    TP <- confusion_matrix$table[2, 2]  
    FP <- confusion_matrix$table[2, 1]  
    FN <- confusion_matrix$table[1, 2]
    TN <- confusion_matrix$table[1, 1]  

    summarize the confusion matrix and save the summary to the 'data/' directory
    create_conf_mat_summary(TP,FP,FN,TN,'data/')

}


# call main function
main(opt$output, opt$workflow) 
