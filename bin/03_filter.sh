#!/bin/bash

# path to settings file 'settings.config'
SETTINGS_FILE=${1}
# name of the current sample
NAME=${2}

# load settings
source $SETTINGS_FILE $NAME

# see README.md for details on conda environment
conda activate $MYENV

# Filter/correct reads
python $PATH_FILTER_PY -1 $R1_COR -2 $R2_COR
mv ${DIR_RCORRECT}/unfixrm_* $DIR_FILTER
