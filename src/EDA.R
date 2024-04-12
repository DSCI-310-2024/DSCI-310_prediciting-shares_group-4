# documentation comments
"This script uses the preprocessed data for EDA.

Usage: src/EDA.R --data=<data> --output=<output>

Options:
--data=<data> path to .csv
--output=<output> Destination folder Ex: data/
" -> doc

# import libraries/packages
suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))
suppressWarnings(library(dsci310utils))

# parse/define command line arguments here
opt <- docopt(doc)

# define main function

main <- function(data, output){
    
    # Set the inputs to be strings
    data1 <- toString(data)
    output1 <- toString(output)

    # Read data from the specified file
    fullData <- suppressMessages(read_csv(data1))

    # Convert 'is_popular' column to a factor
    fullData <- fullData |> mutate(is_popular = as.factor(is_popular))

    # Compute summary statistics (mean, standard deviation, median) for 'shares' column
    share_summary <- data.frame(
        Mean = round(mean(fullData$shares),0),
        SD = round(sd(fullData$shares),0),
        Median = round(median(fullData$shares),0))

    # Save the summary statistics to a csv file
    write_csv(share_summary, paste('data/', 'share_summary.csv', sep = ''))

    # Generate a boxplot of the 'shares' data
    shares_plot <- ggplot(data = fullData) +
    geom_boxplot(aes(y = shares)) +
    labs(title = "Boxplot of Shares") +
    ylab(label = 'Shares') +
    theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15), title = element_text(size = 25))
    
    # Save the plot
    ggsave(filename = paste(output1, 'shares.png', sep = ''), shares_plot, create.dir = TRUE)

    # Calculate the number of observations for each 'is_popular' group and their percentage
    num_obs_training <- fullData |>
      group_by(is_popular) |>
      summarize(n = n()) |>
      mutate(percentage = 100*n/nrow(fullData))

    # Save these observations to a CSV file
    write_csv(num_obs_training, paste('data/', 'num_obs_training.csv', sep = ''))

    # Create and save histograms for number of links, images, and videos in the articles  
    # Histogram 1: Distribution of the number of links in article
    mean_hrefs_plot <- make_histogram(fullData, "num_hrefs", "is_popular",  # nolint
    "Distribution of number of links", "Number of Links")
    ggsave(filename = paste(output1, 'links.png', sep = ''), mean_hrefs_plot, create.dir = TRUE)

    # Histogram 2: Distribution of the number of images in article  
    mean_imgs_plot <- make_histogram(fullData, "num_imgs", "is_popular",  # nolint
    "Distribution of number of Images", "Number of Images")
    ggsave(filename = paste(output1, 'images.png', sep = ''),  mean_imgs_plot, create.dir = TRUE)

    # Histogram 3: Distribution of the number of videos in article
    mean_videos_plot <- make_histogram(fullData, "num_videos", "is_popular",  # nolint
    "Distribution of number of Videos", "Number of Videos")
    ggsave(filename = paste(output1, 'videos.png', sep = ''), mean_videos_plot, create.dir = TRUE)
}



# call main function
main(opt$data, opt$output) 
