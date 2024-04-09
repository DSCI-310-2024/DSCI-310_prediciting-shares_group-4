# Use an official Jupyter image with R
FROM quay.io/jupyter/r-notebook:2024-04-01

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install GNUMake to run Makefile
RUN sudo -S \
    apt-get update && apt-get install -y \
    make \
    gdebi

# Install R packages
RUN mamba install --yes \
    'r-base=4.3.3' \
    'r-docopt=0.7.1' \
    'r-ggally=2.2.1' \
    'r-leaps=3.1' \
    'r-boot=1.3-30' \
    'r-pROC=1.18.5' \
    'r-repr=1.1.6' \
    'r-tidyverse=2.0.0' \
    'r-devtools=2.4.5' \
    'r-caret=6.0_94' \
    'r-tidymodels=1.2.0' \
    'r-shiny=1.8.1.1' \
    'r-irkernel=1.3.2' \
    'r-kknn=1.3.1' \
    'r-testthat=3.2.1'

RUN Rscript -e 'devtools::install_github("DSCI-310-2024/dsci310_utils")'

ARG QUARTO_VERSION="1.4.537"
RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN gdebi --non-interactive quarto-linux-amd64.deb

USER ${NB_UID}
