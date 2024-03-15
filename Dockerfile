# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# Install GNUMake to run Makefile
# RUN apt install make


# Install R packages
RUN mamba install --yes \
    'r-docopt=0.7.1'
    # mamba install -y r-ggally=2.2.1 &&\
    # mamba install -y r-leaps=3.1 &&\
    # mamba install -y r-boot=1.3-30 &&\
    # mamba install -y r-pROC=1.18.5 &&\
    # mamba install -y r-repr=1.1.6 \

RUN apt install make