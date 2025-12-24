#!/bin/bash

HOMEDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"
DATADIR="/hosted/biosc/SchwartzLab/RNAseqData/ZebraFinch/AHDB/EXP1/All_Blood_mRNA_namesConsistent"
CLDATADIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq/Clean_Paired"
USEFUL="/hosted/biosc/SchwartzLab/useful_scripts_files"

###  use the sample IDs in the driver script
sample=$1

mkdir "$CLDATADIR"

### Move to the directory where the data files are.
cd "$CLDATADIR"  

################ Trimmomatic
### Run Trimmomatic in paired end (PE) mode with 6 threads using phred 33 quality score format. 
java -jar /tools/trimmomatic-0.39/trimmomatic-0.39.jar \
         PE -threads 6 -phred33 \
         "${DATADIR}"/"${sample}_1.fq.gz"  "${DATADIR}"/"${sample}_2.fq.gz"  \
       	 "${CLDATADIR}"/"${sample}_1_paired.fq.gz" "${CLDATADIR}"/"${sample}_1_unpaired.fq.gz" "${CLDATADIR}"/"${sample}_2_paired.fq.gz" "${CLDATADIR}"/"${sample}_2_unpaired.fq.gz" \
       	 ILLUMINACLIP:"${USEFUL}"/TruSeq3-PE_Additions.fa:2:35:10 HEADCROP:0 LEADING:20 TRAILING:20 SLIDINGWINDOW:6:20 MINLEN:36
