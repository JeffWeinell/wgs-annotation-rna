#!/bin/bash

SETTINGS_FILE=${1}
NAME=${2}

source $SETTINGS_FILE $NAME

conda activate $MYENV   ### need to install hisat2 to $MYENV

mkdir -p $HISAT2_DIR    ### need to add HISAT2_DIR variable to $SETTINGS_FILE
cd $HISAT2_DIR

# build index for reference
hisat2-build $GENOME $NAME
