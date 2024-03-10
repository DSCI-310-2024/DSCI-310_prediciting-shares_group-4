# Author: Amar Gill
# date: 2024-03-07

all: docs/prediction_report.qmd



# 
data/raw_data.csv	:	src/data.R
	Rscript src/data.R --url=https://archive.ics.uci.edu/static/public/332/online+news+popularity.zip \
		--output=data/

# 
data/clean_data.csv data/training_data.csv data/testing_data.csv	:	src/preprocessing.R	data/raw_data.csv
	Rscript src/preprocessing.R --data=data/raw_data.csv \
		--output=data/

# 
figs/images.png figs/links.png figs/shares.png figs/videos.png data/num_obs_training.csv	:	src/EDA.R	data/training_data.csv
	Rscript src/EDA.R --data=data/training_data.csv \
		--output=figs/

#
src/objects/conf_mat.rds data/model_accuracy.csv	:	src/knn.R data/training_data.csv
	Rscript src/knn.R --data=data/training_data.csv \
		--output=src/

#
docs/prediction_report.qmd	: data/training_data.csv data/testing_data.csv \
figs/images.png figs/links.png figs/shares.png data/num_obs_training.csv \
figs/videos.png src/objects/conf_mat.rds data/model_accuracy.csv
	quarto render prediction_report.qmd --to html



# clean
clean:
	rm -rf figs
	rm -rf data
	rm -rf src/objects
	rm -rf docs