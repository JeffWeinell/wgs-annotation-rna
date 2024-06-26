#!/bin/bash

##### activate conda environment
source ~/.bash_profile
export PATH=/home/jweinell/mendel-nas1/miniconda3/bin:$PATH
conda activate hisat2

CONFIG_PATH=${1}

source $CONFIG_PATH

mkdir -p $BRAKER_WORKDIR
cd $BRAKER_WORKDIR

# build index for reference
hisat2-build $GENOME $NAME
