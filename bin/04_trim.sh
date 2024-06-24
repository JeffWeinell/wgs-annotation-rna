#!/bin/bash

SETTINGS_FILE=${1}
NAME=${2}

source $SETTINGS_FILE $NAME

conda activate $MYENV

# <inputFile1> = $R1_COR
# <inputFile2> = $R2_COR
# <outputFile1P> = $R1PE_TRIMMED
# <outputFile1U> = $R1S_TRIMMED
# <outputFile2P> = $R2PE_TRIMMED
# <outputFile2U> = $R2S_TRIMMED

# trim reads with trimmomatic
trimmomatic PE -threads $NUM_THREADS_TRIMMOMATIC $R1_COR $R2_COR $R1PE_TRIMMED $R1S_TRIMMED $R2PE_TRIMMED $R2S_TRIMMED ILLUMINACLIP:${ADAPTERS}:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36
