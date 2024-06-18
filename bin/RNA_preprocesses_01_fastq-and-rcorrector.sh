#!/bin/bash

SETTINGS_FILE=${1}  # path to settings file
NAME=${2}           # sample name (file name prefix for sample's raw reads)

# load values for variables
source $SETTINGS_FILE $NAME

mkdir -p $DIR_RCORRECT
mkdir -p $DIR_FILTER
mkdir -p $DIR_TRIM_OUT

# see README.md for creating this environment
conda activate $MYENV

# 1. fastqc
fastqc -o $DIR_FASTQC $R1 $R2 -t $NUM_THREADS

# 2. kmer read corrections
cd $DIR_RCORRECT
run_rcorrector.pl -1 $R1 -2 $R2 -od $DIR_RCORRECT -t $NUM_THREADS
