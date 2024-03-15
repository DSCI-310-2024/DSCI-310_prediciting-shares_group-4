# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# Install R packages
RUN conda install -y \
    r-ggally=2.2.1 \
    r-leaps=3.1 \
    r-boot=1.3-30 \
    r-pROC=1.18.5 \
    r-repr=1.1.6 \
    r-docopt=0.7.1
