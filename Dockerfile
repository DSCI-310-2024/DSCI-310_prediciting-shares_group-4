# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

USER root

# Install GNUMake to run Makefile
RUN sudo -S \
    apt-get update && apt-get install \
    make \
    gdebi

# Install R packages
RUN mamba install --yes \
    'r-docopt=0.7.1' \
    'r-kknn=1.3.1'

ARG QUARTO_VERSION="1.4.537"
RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN gdebi --non-interactive quarto-linux-amd64.deb

USER ${NB_UID}
