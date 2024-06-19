# wgs-annotation-rna
About: Pipeline for RNAseq assembly for whole genome annotation


#### 1. create a conda environment with all necessary programs
` conda create --name transcriptomes -c bioconda trinity bowtie2 fastqc rcorrector ntcard `

#### 2. run fastqc and rcorrector
`SAMPLES_FILE=/path/to/XXXXX-rna-samples.txt
SETTINGS_FILE=/path/to/XXXXX-settings.config
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
`
#### 3. filter


#### 4. trim with trimmomatic


#### 5. assemble with trinity


#### 6. merge assemblies by isolate





