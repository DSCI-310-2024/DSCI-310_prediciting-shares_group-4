# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# USER ${NB_UID}
# Install R packages
RUN mamba install --yes \
    'r-docopt=0.7.1' \
    'r-kknn=1.3.1'

# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install GNUMake to run Makefile
RUN sudo -S \
    apt-get update && apt-get install make

USER ${NB_UID}
