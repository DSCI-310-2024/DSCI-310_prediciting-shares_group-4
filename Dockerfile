# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# Install GNUMake to run Makefile
RUN sudo -S \
    apt-get install --yes --no-install-recommends \
    make


# Install R packages
RUN mamba install --yes \
    'r-docopt=0.7.1' \
    'r-ggally=2.2.1' \
    'r-leaps=3.1' \
    'r-boot=1.3-30' \
    'r-pROC=1.18.5' \
    'r-repr=1.1.6'

