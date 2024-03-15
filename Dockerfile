# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# Install R packages
RUN mamba install -n base --yes \
    'r-docopt' \
    'r-ggally=2.2.1' \
    'r-leaps=3.1' \
    'r-boot=1.3-30' \
    'r-pROC=1.18.5' \
    'r-repr=1.1.6' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install GNUMake to run Makefile
RUN sudo -S \
    apt-get update && apt-get install make

USER ${NB_UID}
