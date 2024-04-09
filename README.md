# DSCI-310_predicting-shares_group-4

## Predicting the Shares of News Articles based on Social networks

### Group members:

Amar Gill, Anshnoor Kaur, Hanyu Dai, Yanxin Liang

### Overview

Use dataset from open source websites [UCI Machine Learning Repository: Data Sets](https://archive.ics.uci.edu/dataset/332/online+news+popularity) to predict the number of shares of a article. We split the data into traing and testing parts, and proceed full model and reduced model to make the results more reliable and efficent enough.

### Dependencies

To finish up this project you will need to install:

-   Docker

### Dockerfile

To use dockerfile, first download the release and extract it on your drive. Then set your working directory to the project. Once done, input the following:

```
docker-compose run analysis-env
```


### Makefile

Runs the complete analysis all the way from reading and cleaning data to creating training and testing sets, creating a workflow fit on the training data and eventually predicting shares and looking at the model accuracy using testing data.

Renders the prediction report from the .qmd file into an HTML format and saves it to the docs folder.

Using the Makefile:

- Run the analysis: Running make all at the command line will run the analysis easily from top to bottom
- Undo the analysis: Running make clean at the command line will undo the analysis and delete all generated data and files

### Licenses

The software content of this template repository licensed under the [MIT License](https://spdx.org/licenses/MIT.html). See the [license file](LICENSE.md) for more information.
