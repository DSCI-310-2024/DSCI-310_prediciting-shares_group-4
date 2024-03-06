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


# parse/define command line arguments here
opt <- docopt(doc)

# define main function
main <- function(url, output){
    url1 <- toString(url)
    output1 <- toString(output)
    temp_path <- paste(output1, 'data.zip', sep = "")
    suppressMessages(download.file(url1, temp_path ,mode = 'wb'))
    unzip(temp_path, exdir = output1)
    data <- suppressMessages(read_csv(paste(output1, 'OnlineNewsPopularity/OnlineNewsPopularity.csv', sep = "")))
    unlink(temp_path)
    unlink(paste(output1, 'OnlineNewsPopularity', sep = ""), recursive = TRUE)
    write_csv(data, paste(output1, 'raw_Data.csv', sep = ''))
}

# code for other functions & tests goes here

# call main function
main(opt$url, opt$output) # pass any command line args to main here
