
# DOCKER containers

These Docker containers are part of pipelines designed to run on AWS clioud.  
Majority of containers are selfexplanatory and run specific tool. Here is short description of few which include pipelines. They require specic dir names created on instance before the run. Check pipelinescript for each container to see specifics.  

## qualimapUbuntu14

Container to run quality check on FASTQ or BAM files using Qualimap2 or FastQC. Also it allow to run Trimmomatic0.36 to trimm FASTQ files.  
All required files must be placed in working directory before the container run.  

It includes pipeline BASH script `quali.sh`. To run this script you need to provide several environment variables:  

`THREADS` - defines number of CPUs.  

`ANALYSIS` - has options "qualimap", "trimm" and "fastqc". This is main variable defines the type of the run.  

To run "fastqc" analysis you just need to provide FASTQ files in a working directory. It designed to run on paired reads samples, where file names must contain "_R1" and "_R2".  

To run "qualimap" provide additional variables. This Qualimap2 script specified to run for RNA-seq BAM files.  

`GTFFILE` - species the path to GTF file in working directory.  

Finally, to run "trimm" command specify following variables for Trimmomatic:  

```
CROP_LEN=60
MIN_LEN=36
HEADCROP=9
```
## rnaalignment

This container designed to run alignment of paired FASTQ files using STAR aligner.  
All required files must be placed in working directory before the container run.  
It requires following variables:  

`THREADS` - defines number of CPUs.  
`PREFIX_STAR` - file prefix for STAR output BAM.


