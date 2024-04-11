# DSCI-310_predicting-shares_group-4

## Predicting the Shares of News Articles based on Social networks

### Group members:

Amar Gill, Anshnoor Kaur, Hanyu Dai, Yanxin Liang

### Overview

This project aims to answer the question of whether the number of links, images and videos in an article can predict the number of shares the article will get on social media.

We use the dataset available at this link: https://archive.ics.uci.edu/dataset/332/online+news+popularity 
The dataset contains statistical information about articles published by Mashable over a period of 2 years and is publicly available.

We use knn classification and split the data into training and testing sets to fit and test our model to make sure that the results are reliable.

### Dependencies

To finish up this project you will need to install:

-   Docker

The Docker container takes care of all dependencies required for running the analysis. The dependencies include the following:

R packages:

- r-base
- r-docopt
- r-ggally
- r-leaps
- r-boot
- r-pROC
- r-repr
- r-tidyverse
- r-devtools
- r-caret
- r-tidymodels
- r-shiny
- r-irkernel
- r-kknn
- r-testthat

R package from GitHub created by the authors:

- DSCI-310-2024/dsci310_utils

Other:

- quarto

### Running the Analysis

1. Clone this repository from GitHub to your local machine.

```
git clone https://github.com/DSCI-310-2024/DSCI-310_predicting-shares_group-4.git
```

2. Navigate to the project directory in your local machine.

```
cd DSCI-310_predicting-shares_group-4
```

3. Make sure your Docker engine is running.

Running the below code in your terminal/ command prompt should give you information about your Docker Installation, version, details, images etc if your Docker engine is running.

```
docker info
```

4. Use docker-compose to build the containerized environment and run the analysis

```
docker-compose run analysis-env
```

5. Use ```make clean``` to clean up results from any previous runs of the analysis. Then finally use ```make all``` to run the analysis.

6. The analysis can take a few minutes to run. The results can be viewed by typing ```open docs/prediction_report.html```

### Makefile

Runs the complete analysis all the way from reading and cleaning data to creating training and testing sets, creating a workflow fit on the training data and eventually predicting shares and looking at the model accuracy using testing data.

Renders the prediction report from the .qmd file into an HTML format and saves it to the docs folder.

Using the Makefile:

- Clean first with below code
```
make clean
```
- Run the analysis: Running make all at the command line will run the analysis easily from top to bottom
```
make all
```
- Undo the analysis: Running make clean at the command line will undo the analysis and delete all generated data and files
```
make clean
```
- Exit the container with follow code
```
quit
```

### Licenses

The software content of this template repository licensed under the [MIT License](https://spdx.org/licenses/MIT.html). See the [license file](LICENSE.md) for more information.
