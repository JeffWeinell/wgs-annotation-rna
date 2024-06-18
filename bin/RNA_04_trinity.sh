#!/bin/bash

# path to settings file 'settings.config'
SETTINGS_FILE=$1
# name of current sample to process
NAME=$2

# load settings
source $SETTINGS_FILE $NAME

# activate conda environment (see README.md for details)
conda activate $MYENV

# Assemble with trinity
Trinity --full_cleanup --seqType fq  --left ${R1PE_TRIMMED} --right ${R2PE_TRIMMED} --single ${R1S_TRIMMED} ${R2S_TRIMMED} --normalize_reads --CPU $NUM_CPU_TRINITY --max_memory $MAX_MEM_TRINITY --output $DIR_TRINITY_OUT
