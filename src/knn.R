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
source("./R/create_conf_mat_summary.R")

# parse/define command line arguments here
opt <- docopt(doc)

# define main function

main <- function(output, workflow){
    output1 <- toString(output)
    workflow <- readRDS(toString(workflow))
  # predicting number of shares for testing data
    articles_testing <- suppressMessages(read_csv('data/testing_data.csv'))
    articles_testing <- articles_testing |> mutate(is_popular = as.factor(is_popular))

    articles_predict <- predict(workflow, articles_testing) |>
    bind_cols(articles_testing)

    articles_accuracy <- articles_predict |>
    metrics(truth = is_popular, estimate = .pred_class) |>
    filter(.metric == "accuracy")
    write_csv(articles_accuracy, paste('data/', 'model_accuracy.csv', sep = ''))

    confusion_matrix <- articles_predict |>
    conf_mat(truth = is_popular, estimate = .pred_class)

    saveRDS(confusion_matrix, paste(output1, 'objects/conf_mat.rds', sep = ''))

    TP <- confusion_matrix$table[2, 2]  
    FP <- confusion_matrix$table[2, 1]  
    FN <- confusion_matrix$table[1, 2]
    TN <- confusion_matrix$table[1, 1]  

    create_conf_mat_summary(TP,FP,FN,TN,'data/')

}

# code for other functions & tests goes here



# call main function
main(opt$output, opt$workflow) # pass any command line args to main here
