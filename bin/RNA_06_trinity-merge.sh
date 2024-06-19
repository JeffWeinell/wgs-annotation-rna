#!/bin/bash

#### still working on this ####

# path to settings.config file
SETTINGS_FILE=${1}
# name of isolate with samples to process
ISOLATE=${2}

# load settings
source $SETTINGS_FILE

# activate working environment
conda activate $MYENV

cd $DIR_TRINITY

# add tissue type to fasta headers
FILES=$(awk -v dir=$DIR_TRINITY -v iso=$ISOLATE '$2==iso{print dir"/"$5}' | sed 's|.fastq.gz$||g')
NUMFILES=$(echo "$FILES" | wc -l)
for i in $(seq 1 $NUMFILES);
do
	FILEi=$(echo "$FILES" | awk -v i=$i 'NR==i{print}')
	TISSUE=$(echo $FILEi | sed "s|trinity_${NAME}-||g" | sed "s|.Trinity.fasta||g")
	echo $i $TISSUE
	sed "s|^\(>\)|\1${TISSUE}_|" $FILEi > labelled_${FILEi}
done

# combine all labelled trinity transcripts for sample
FILES_LABELLED=$(find ${DIR_TRINITY}"/labelled_"*${NAME}*)
FILE_TOTAL=${DIR_TRINITY}"/total_tissue_"${NAME}".Trinity.fasta"
cat $FILES_LABELLED > $FILE_TOTAL

