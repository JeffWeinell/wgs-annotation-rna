# wgs-annotation-rna
About: Pipeline for RNAseq assembly for whole genome annotation


#### create a conda environment with all necessary programs
``` conda create --name transcriptomes -c bioconda trinity bowtie2 fastqc rcorrector ntcard ```

#### create samples.config and settings.congig files

```
# create samples.config file


# create settings.config file
 

```

#### run fastqc and rcorrector

```
# set variables specifying paths to your samples.config and settings.config files
SAMPLES_FILE=/path/to/XXXXX-samples.config
SETTINGS_FILE=/path/to/XXXXX-settings.config

# for each sample, run 01_fastqc.sh and 02_rcorrector.sh on raw paired-end reads
SAMPLE_NAMES=$(awk '{print $1}' $SAMPLES_FILE | uniq )
NUMSAMPLES=$(echo "$SAMPLE_NAMES" | wc -l)
for i in $(seq 1 $NUMSAMPLES);
do
	NAMEi=$(echo "$SAMPLE_NAMES" | awk -v i=$i 'NR==i{print}')
	source $SETTINGS_FILE $NAMEi
	echo $i $NAMEi
	sbatch --mem=$MAX_MEM_FASTQC --tasks-per-node=$NUM_THREADS_FASTQC ./bin/01_fastqc.sh $SETTINGS_FILE $NAMEi
	sbatch --mem=$MAX_MEM_RCORRECTOR --tasks-per-node=$NUM_THREADS_RCORRECTOR ./bin/02_rcorrector.sh $SETTINGS_FILE $NAMEi
done
```

#### filter



#### trim with trimmomatic



#### assemble with trinity



#### merge assemblies by isolate





