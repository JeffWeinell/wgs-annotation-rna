#!/bin/bash

SETTINGS_FILE=${1}  # path to settings file
NAME=${2}           # sample name (one of the values in column 1 of $SAMPLES_FILE)

# load values for variables
source $SETTINGS_FILE $NAME

# see README.md for creating this environment
conda activate $MYENV

mkdir -p $DIR_FASTQC
mkdir -p $DIR_RCORRECT
mkdir -p $DIR_FILTER
mkdir -p $DIR_TRIM_OUT
mkdir -p $DIR_TRINITY

# run fastqc
fastqc -o $DIR_FASTQC $R1_RAW $R2_RAW -t $NUM_THREADS_FASTQC
