# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# Install GNUMake to run Makefile
RUN apt install make

# Install R packages
RUN conda install -c -y r \
    r-tidyverse=2.0.0 \
    r-tidymodels=1.1.1 \
    r-ggally=2.2.1 \
    r-leaps=3.1 \
    r-boot=1.3-30 \
    r-pROC=1.18.5 \
    r-repr=1.1.6 \
    r-docopt=0.7.1
