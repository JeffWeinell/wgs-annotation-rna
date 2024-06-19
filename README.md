# Pipeline for RNAseq assembly and functional annotation of whole genomes


#### setup working environment

```
# create conda environment with all necessary programs
conda create --name transcriptomes -c bioconda trinity bowtie2 fastqc rcorrector ntcard
```

#### clone this repository

```
git clone https://github.com/JeffWeinell/wgs-annotation-rna
```

#### prepare samples.config and settings.config files

```
# edit a copy of samples.config
cp path/to/samples.config path/to/my-samples.config
```

```
# edit a copy of settings.config
cp path/to/settings.config path/to/my-settings.config
```

#### run fastqc and rcorrector

```
# specify paths to config files
SAMPLES_FILE=path/to/my-samples.config
SETTINGS_FILE=path/to/my-settings.config

# for each sample, run 01_fastqc.sh and 02_rcorrector.sh on raw paired-end reads
SAMPLE_NAMES=$(awk '{print $1}' $SAMPLES_FILE | uniq )
NUMSAMPLES=$(echo "$SAMPLE_NAMES" | wc -l)
for i in $(seq 1 $NUMSAMPLES);
do
	NAMEi=$(echo "$SAMPLE_NAMES" | sed "${i}q;d")
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





