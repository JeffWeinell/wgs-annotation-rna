#!/bin/bash

SETTINGS_FILE=${1}  # path to settings file
NAME=${2}           # sample name (one of the values in column 1 of $SAMPLES_FILE)

# load values for variables
source $SETTINGS_FILE $NAME

# activate working environment
conda activate $MYENV

# run run_rcorrector for kmer read corrections
run_rcorrector.pl -1 $R1_RAW -2 $R2_RAW -od $DIR_RCORRECT -t $NUM_THREADS_RCORRECTOR
