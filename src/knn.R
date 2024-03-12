# documentation comments
"This script uses the preprocessed data to create a KNN model.

Usage: src/knn.R --data=<data> --output=<output>

Options:
--data=<data> path to .csv
--output=<output> Destination folder Ex: src/
" -> doc

# import libraries/packages
suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))
suppressMessages(library(kknn))
suppressMessages(library(tidymodels))

# parse/define command line arguments here
opt <- docopt(doc)

# define main function

main <- function(data, output){
    data1 <- toString(data)
    output1 <- toString(output)
    fullData <- suppressMessages(read_csv(data1))

    fullData <- fullData |> mutate(is_popular = as.factor(is_popular))

    articles_recipe <- recipe(is_popular ~ num_hrefs + num_imgs + num_videos, data = fullData) |>
    step_scale(all_predictors()) |>
    step_center(all_predictors())

    tune_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = tune()) |>
    set_engine("kknn") |>
    set_mode("classification")

    set.seed(2023) # set the seed

    # cross-validation
    articles_vfold <- vfold_cv(fullData, v = 5, strata = is_popular)

    # create a set of K values
    kvals <- tibble(neighbors = seq(from = 1, to = 100, by = 5))

    # data analysis workflow                       
        knn_results <- workflow() |>
        add_recipe(articles_recipe) |>
        add_model(tune_spec) |>
        tune_grid(resamples = articles_vfold, grid = kvals) |>
        collect_metrics()

    accuracies <- knn_results |>
        filter(.metric == "accuracy")

    best_k_plot <- accuracies |>
        ggplot(aes(x = neighbors, y = mean)) +
        geom_point() +
        geom_line() +
        labs(x = "Number of neighbors", y = "Accuracy Estimate") +
        ggtitle("Accuracy Estimates vs. Number of Neighbors")
    ggsave(filename = paste('figs/', 'best_k.png', sep = ''), best_k_plot)

    knn_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = 50) |>
    set_engine("kknn") |>
    set_mode("classification")

    knn_fit <- workflow() |>
    add_recipe(articles_recipe) |>
    add_model(knn_spec) |>
    fit(data = fullData)

    articles_testing <- suppressMessages(read_csv('data/testing_data.csv'))
    articles_testing <- articles_testing |> mutate(is_popular = as.factor(is_popular))

    articles_predict <- predict(knn_fit, articles_testing) |>
    bind_cols(articles_testing)

    articles_accuracy <- articles_predict |>
    metrics(truth = is_popular, estimate = .pred_class) |>
    filter(.metric == "accuracy")
    write_csv(articles_accuracy, paste('data/', 'model_accuracy.csv', sep = ''))


    confusion_matrix <- articles_predict |>
    conf_mat(truth = is_popular, estimate = .pred_class)
    dir.create(file.path(output1, 'objects'), showWarnings = FALSE)
    saveRDS(confusion_matrix, paste(output1, 'objects/conf_mat.rds', sep = ''))


    TP <- confusion_matrix$table[2, 2]  
    FP <- confusion_matrix$table[2, 1]  
    FN <- confusion_matrix$table[1, 2]
    TN <- confusion_matrix$table[1, 1]  

    knn_precision <- TP / (TP + FP)
    knn_recall <- TP / (TP + FN)
    knn_accuracy <- (TP + TN) / (TP + FP + FN + TN)

    conf_mat_summary <- data.frame(
      Precision = round(knn_precision,4),
      Recall = round(knn_recall,4),
      Accuracy = round(knn_accuracy,4))
    write_csv(conf_mat_summary, paste('data/', 'conf_mat_summary.csv', sep = ''))




}

# code for other functions & tests goes here

# call main function
main(opt$data, opt$output) # pass any command line args to main here
