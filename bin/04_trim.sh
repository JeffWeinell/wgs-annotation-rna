#!/bin/bash

SETTINGS_FILE=${1}
NAME=${2}

source $SETTINGS_FILE $NAME

conda activate $MYENV

# trim reads with trimmomatic
trimmomatic PE -threads $NUM_THREADS_TRIMMOMATIC *R1*.fq.gz *R2*.fq.gz ${R1PE_TRIMMED} ${R1S_TRIMMED} ${R2PE_TRIMMED} ${R2S_TRIMMED} ILLUMINACLIP:${ADAPTERS}:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36
