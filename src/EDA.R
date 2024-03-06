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

# parse/define command line arguments here
opt <- docopt(doc)

# define main function

main <- function(data, output){
    data1 <- toString(data)
    output1 <- toString(output)
    fullData <- suppressMessages(read_csv(data1))

    fullData <- fullData |> mutate(is_popular = as.factor(is_popular))

    shares_plot <- ggplot(data = fullData) +
    geom_boxplot(aes(y = shares)) +
    labs(title = "Boxplot of Shares") +
    ylab(label = 'Shares') +
    theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15), title = element_text(size = 25))
    ggsave(filename = paste(output1, 'shares.png', sep = ''), shares_plot)

    # Histogram 1: Distribution of the number of links in article
    mean_hrefs_plot <- ggplot(fullData, aes(x = num_hrefs, fill = is_popular)) +
    geom_histogram(color = "black", bins = 30) +
    labs(title = "Distribution of number of links", 
        x = "Number of links", 
        fill = "Popular")
    ggsave(filename = paste(output1, 'links.png', sep = ''), mean_hrefs_plot)

    # Histogram 2: Distribution of the number of images in article  
    mean_imgs_plot <- ggplot(fullData, aes(x = num_imgs, fill = is_popular)) +
    geom_histogram(color = "black", bins = 30) +
    labs(title = "Distribution of number of images", 
        x = "Number of images", 
        fill = "Popular")
    ggsave(filename = paste(output1, 'images.png', sep = ''), mean_imgs_plot)

    # Histogram 3: Distribution of the number of videos in article
    mean_videos_plot <- ggplot(fullData, aes(x = num_videos, fill = is_popular)) +
    geom_histogram(color = "black", bins = 30) +
    labs(title = "Distribution of number of videos", 
        x = "Number of videos", 
        fill = "Popular")
    ggsave(filename = paste(output1, 'videos.png', sep = ''), mean_videos_plot)
}

# code for other functions & tests goes here

# call main function
main(opt$data, opt$output) # pass any command line args to main here
