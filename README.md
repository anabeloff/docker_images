
# DOCKER containers

These Docker containers are part of pipelines designed to run on AWS cloud.  
Majority of containers are selfexplanatory and run a specific tool. Here is short description of few, which include complex pipelines. They require specic directory names created on instance before the run. Check pipelinescript for each container to see specifics.  

## qualimapUbuntu14

Container to run quality check on FASTQ or BAM files using Qualimap2 or FastQC. Also it allows to run Trimmomatic0.36 to trimm FASTQ files.  
All required files must be placed in working directory before the container run.  

It includes pipeline BASH script `quali.sh`. To run this script you need to provide several environment variables:  

`THREADS` - defines number of CPUs.  

`ANALYSIS` - has options "qualimap", "trimm" and "fastqc". This is main variable defines the type of the run.  

To run "fastqc" analysis you just need to provide FASTQ files in a working directory. It designed to run on paired reads samples, where file names must contain "_R1" and "_R2" in their names.  

To run "qualimap" provide additional variables. This Qualimap2 script specified to run for RNA-seq BAM files.  

`GTFFILE` - species the path to GTF file in working directory.  

Finally, to run "trimm" command specify following variables for Trimmomatic:  

```
CROP_LEN=60
MIN_LEN=36
HEADCROP=9
```
## rnaalignment

This container is designed to run alignment of paired FASTQ files using STAR aligner.  
All required files must be placed in working directory before the container run.  
It requires following variables:  

`THREADS` - defines number of CPUs.  
`PREFIX_STAR` - file prefix for STAR output BAM.

## rrnaseq

The container specifically designed to run R script `SEobject.R`. This script takes several BAM files to create SummirizedExperiment object for further analysis with DESeq2 package.  

It requires following variables:  
`GFFFILE` - path to GFF file in working directory.  
`SE_NAME` - output file name. Script will create .RData file, which can used in R.  
`SPECIES_NAME` - character string specifying species name. For example "Homo sapiens".  
