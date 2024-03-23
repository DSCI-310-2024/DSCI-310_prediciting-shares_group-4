#' unzip URL observations
#'
#' Extracts the files in a zipped folder that is
#' downloaded from a URL.
#'
#' @param url A URL that links to a zipped folder download.
#' @param output Location to extract the files to
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples
#' unzip_URL('https://archive.ics.uci.edu/static/public/332/online+news+popularity.zip', 'data/')
unzip_URL <- function(url, output) {
  #unzip a zipped folder and extract files to target directory
    temp_path <- './a.zip'
    suppressMessages(download.file(url, temp_path ,mode = 'wb'))
    checkWarning <- tryCatch(unzip(temp_path, exdir = output), error=function(e) e, warning=function(w) w)
    file.remove(temp_path)
    if (is(checkWarning, "warning")) stop("Error")
}