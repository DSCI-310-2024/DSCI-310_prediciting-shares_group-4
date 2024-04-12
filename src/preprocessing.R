# documentation comments
"This script processes the data for EDA and the KNN model.

Usage: src/preprocessing.R --data=<data> --output=<output>

Options:
--data=<data> path to .csv
--output=<output> Destination folder Ex: data/
" -> doc

# import libraries/packages
suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))
suppressMessages(suppressWarnings(library(tidymodels)))
suppressWarnings(library(dsci310utils))

# parse/define command line arguments here
opt <- docopt(doc)

# define main function

main <- function(data, output){

    # Convert the input data path and output directory arguments to strings
    data1 <- toString(data)
    output1 <- toString(output)

    # Read data from the provided file path
    fullData <- suppressMessages(read_csv(data1))

    # Specify the columns required for further analysis
    required_columns <- c("shares", "num_hrefs", "num_imgs", "num_videos")

    #Cleaning the data frame and returns a cleaned data frame with only the required columns.
    clean_Data <- clean_data(fullData,required_columns)

    # Add a new column 'is_popular' and convert it into a factor
    clean_Data <- clean_Data |>
      dplyr::mutate(is_popular = ifelse(shares < 1400, 0, 1),
                    is_popular = as.factor(is_popular))

    # Save the cleaned and processed data to a CSV file
    write_csv(clean_Data, paste(output1, 'clean_Data.csv', sep = ''))

    #set a seed
    set.seed(2024)

    # Split the data into training and testing sets
    data_split <- initial_split(clean_Data, prop = 0.6, strata = is_popular)

    # Extract training data from the split
    training_Data <- training(data_split)

    # Extract testing data from the split
    testing_Data <- testing(data_split)

    # Save the training and testing datasets to CSV files
    write_csv(training_Data, paste(output1, 'training_Data.csv', sep = ''))
    write_csv(testing_Data, paste(output1, 'testing_Data.csv', sep = ''))
}


# call main function
main(opt$data, opt$output) 