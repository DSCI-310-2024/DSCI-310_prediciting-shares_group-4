# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

USER root
# Install GNUMake to run Makefile
RUN sudo -S \
    apt-get update && apt-get install make

USER ${NB_UID}

# Install R packages
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/docopt_0.7.1.tar.gz', repos=NULL, type = 'source')"


