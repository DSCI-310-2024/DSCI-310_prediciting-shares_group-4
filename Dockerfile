# Use an official Jupyter image with R
FROM jupyter/r-notebook:latest

# Install R packages
RUN R -e "install.packages('renv', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('GGally', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('tidymodels', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('tidyverse', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('leaps', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('caret', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('boot', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('pROC', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('repr', repos='http://cran.us.r-project.org')" \
    && R -e "install.packages('glmnet', repos='http://cran.us.r-project.org')"
