#!/bin/bash

# Alignment
echo "HISAT2 alignment!"

        if [[ ! -d $OUT_DIR ]]; then 
                mkdir -p  $OUT_DIR;
        fi



# Identify R1 and R2 files 
declare -a infileR1
declare -a infileR2
for files in *.fastq.gz
do 
        if [[ $files == *_R1* ]];
        then
                infileR1+=($(ls $files));
                
        elif [[ $files == *_R2* ]];
        then
                infileR2+=($(ls $files));
        fi
done

len=${#infileR1[@]};
        
for ((i=0;i<$len;i++));
do              
if [ $SRA_ID ];
then

outfile=$OUT_DIR/$SRA_ID".sam";
outfile_bam=$OUT_DIR/$SRA_ID".bam";

              hisat2 \
              --threads $THREADS \
              --time \
              --new-summary \
              -x grch38primary \
              --sra-acc $SRA_ID \
              -S $outfile

else

outfile=$OUT_DIR/$BASE_ID".sam";
outfile_bam=$OUT_DIR/$BASE_ID".bam";

              hisat2 \
              --threads $THREADS \
              --time \
              --new-summary \
              -x grch38primary \
              -1 ${infileR1[$i]} \
              -2 ${infileR2[$i]} \
              -S $outfile
fi
              
        samtools view -bS $outfile > $outfile_bam
        samtools sort $outfile_bam -o $outfile_bam

done

