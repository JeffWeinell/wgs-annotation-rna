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


### preprocess raw reads
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
	sbatch --mem=$MAX_MEM_RCORRECTOR --time=24:00:00 --tasks-per-node=$NUM_THREADS_RCORRECTOR ./bin/02_rcorrector.sh $SETTINGS_FILE $NAMEi
done
```

#### filter

```
# specify paths to config files
SAMPLES_FILE=path/to/my-samples.config
SETTINGS_FILE=path/to/my-settings.config

# for each sample, run 03_filter.sh on rcorrected reads
SAMPLE_NAMES=$(awk '{print $1}' $SAMPLES_FILE | uniq)
NUMSAMPLES=$(echo "$SAMPLE_NAMES" | wc -l)
for i in $(seq 1 $NUMSAMPLES);
do
	NAMEi=$(echo "$SAMPLE_NAMES" | sed "${i}q;d")
	source $SETTINGS_FILE $NAMEi
	echo $i $NAMEi
	sbatch --mem=$MAX_MEM_PYFILTER --time=24:00:00 --tasks-per-node=$NUM_THREADS_PYFILTER  ./bin/03_filter.sh $SETTINGS_FILE $NAMEi
done
```

#### trim with trimmomatic

```
# specify paths to config files
SAMPLES_FILE=path/to/my-samples.config
SETTINGS_FILE=path/to/my-settings.config

# for each sample, run 04_trim.sh on rcorrected, filtered reads
SAMPLE_NAMES=$(awk '{print $1}' $SAMPLES_FILE | uniq)
NUMSAMPLES=$(echo "$SAMPLE_NAMES" | wc -l)
for i in $(seq 1 $NUMSAMPLES);
do
	NAMEi=$(echo "$SAMPLE_NAMES" | sed "${i}q;d")
	source $SETTINGS_FILE $NAMEi
	echo $i $NAMEi
	sbatch --mem=$MAX_MEM_TRIMMOMATIC --time=24:00:00 --tasks-per-node=$NUM_THREADS_TRIMMOMATIC ./bin/04_trim.sh $SETTINGS_FILE $NAMEi
done
```

### assemble transcriptomes

#### assemble with trinity
```
# specify paths to config files
SAMPLES_FILE=path/to/my-samples.config
SETTINGS_FILE=path/to/my-settings.config

# for each sample, run 05_trinity.sh to assemble rcorrected, filtered, trimmed reads
SAMPLE_NAMES=$(awk '{print $1}' $SAMPLES_FILE | uniq)
NUMSAMPLES=$(echo "$SAMPLE_NAMES" | wc -l)
for i in $(seq 1 $NUMSAMPLES);
do
	NAMEi=$(echo "$SAMPLE_NAMES" | sed "${i}q;d")
	source $SETTINGS_FILE $NAMEi
	echo $i $NAMEi
	sbatch --mem=$MAX_MEM_TRINITY --time=150:00:00 --tasks-per-node=$NUM_THREADS_TRINITY ./bin/05_trinity.sh $SETTINGS_FILE $NAMEi
done
```

#### merge tissue-transcriptomes by individual

```
# specify paths to config files
SAMPLES_FILE=path/to/my-samples.config
SETTINGS_FILE=path/to/my-settings.config

# for each isolate...
./bin/06_trinity-merge.sh

```







