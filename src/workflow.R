# documentation comments
"This script uses the preprocessed data to create a KNN model.

Usage: src/knn.R --data=<model> --output=<output>

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

    # Convert the input data path and output directory to strings
    data1 <- toString(data)
    output1 <- toString(output)

    # Read data from the provided file path
    fullData <- suppressMessages(read_csv(data1))

    # Convert 'is_popular' column to a factor
    fullData <- fullData |> mutate(is_popular = as.factor(is_popular))

    # Prepare the data using a recipe for the KNN model, scaling and centering predictors
    articles_recipe <- recipe(is_popular ~ num_hrefs + num_imgs + num_videos, data = fullData) |>
    step_scale(all_predictors()) |>
    step_center(all_predictors())

    # Configure the KNN model
    tune_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = tune()) |>
    set_engine("kknn") |>
    set_mode("classification")

    set.seed(2023) # set the seed

    # Perform 5-fold cross-validation stratified by 'is_popular'
    articles_vfold <- vfold_cv(fullData, v = 5, strata = is_popular)

    # create a set of K values
    kvals <- tibble(neighbors = seq(from = 1, to = 100, by = 5))

    # data analysis workflow                       
        knn_results <- workflow() |>
        add_recipe(articles_recipe) |>
        add_model(tune_spec) |>
        tune_grid(resamples = articles_vfold, grid = kvals) |>
        collect_metrics()

    # Extract accuracy metrics from the results
    accuracies <- knn_results |>
        filter(.metric == "accuracy")

    # Plot accuracy estimates versus number of neighbors to find the best K value
    best_k_plot <- accuracies |>
        ggplot(aes(x = neighbors, y = mean)) +
        geom_point() +
        geom_line() +
        labs(x = "Number of neighbors", y = "Accuracy Estimate") +
        ggtitle("Accuracy Estimates vs. Number of Neighbors")

    # Save the plot to a file in the specified directory
    ggsave(filename = paste('docs/figs/', 'best_k.png', sep = ''), best_k_plot, create.dir = TRUE)

    # Define a specific KNN model using the best k 
    knn_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = 50) |>
    set_engine("kknn") |>
    set_mode("classification")

    # Fit the final KNN model
    knn_fit <- workflow() |>
    add_recipe(articles_recipe) |>
    add_model(knn_spec) |>
    fit(data = fullData)

    # Create a directory for saving model objects
    dir.create(file.path(output1, 'objects'), showWarnings = FALSE)

    # Save the fitted model object
    saveRDS(knn_fit, paste(output1, "objects/knn_fit.rds", sep = ''))
}



# call main function
main(opt$data, opt$output)
