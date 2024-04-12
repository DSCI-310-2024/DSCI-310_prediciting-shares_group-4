# documentation comments
"This script saves the data locally from the URL passed through.

Usage: src/data.R --url=<url> --output=<output>

Options:
--url=<url> URL link to zipped data
--output=<output> Destination folder Ex: data/
" -> doc

# import libraries/packages
suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))
suppressWarnings(library(dsci310utils))


# parse/define command line arguments here
opt <- docopt(doc)

# define main function
main <- function(url, output){
    
    # Set the inputs to be strings
    url1 <- toString(url)
    output1 <- toString(output)

    # Download the zip file and extract it to the given output
    unzip_URL(url1,output1)

    # Read the .csv into a data frame
    data <- suppressMessages(read_csv(paste(output1, 'OnlineNewsPopularity/OnlineNewsPopularity.csv', sep = "")))
    
    # Delete the unneeded extracted files
    unlink(paste(output1, 'OnlineNewsPopularity', sep = ""), recursive = TRUE)

    # Save the data frame as raw Data
    write_csv(data, paste(output1, 'raw_Data.csv', sep = ''))
}

# code for other functions & tests goes here

# call main function
main(opt$url, opt$output) # pass any command line args to main here
