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
    data1 <- toString(data)
    output1 <- toString(output)
    fullData <- suppressMessages(read_csv(data1))

    fullData <- fullData |> mutate(is_popular = as.factor(is_popular))

    share_summary <- data.frame(
        Mean = round(mean(fullData$shares),0),
        SD = round(sd(fullData$shares),0),
        Median = round(median(fullData$shares),0))
    write_csv(share_summary, paste('data/', 'share_summary.csv', sep = ''))

    shares_plot <- ggplot(data = fullData) +
    geom_boxplot(aes(y = shares)) +
    labs(title = "Boxplot of Shares") +
    ylab(label = 'Shares') +
    theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15), title = element_text(size = 25))
    ggsave(filename = paste(output1, 'shares.png', sep = ''), shares_plot, create.dir = TRUE)

    num_obs_training <- fullData |>
      group_by(is_popular) |>
      summarize(n = n()) |>
      mutate(percentage = 100*n/nrow(fullData))
    write_csv(num_obs_training, paste('data/', 'num_obs_training.csv', sep = ''))

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

# code for other functions & tests goes here

# call main function
main(opt$data, opt$output) # pass any command line args to main here
