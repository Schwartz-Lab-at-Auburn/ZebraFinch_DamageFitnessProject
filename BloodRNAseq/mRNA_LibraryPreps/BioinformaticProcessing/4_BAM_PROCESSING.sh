#!/bin/bash

HOMEDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"
CLDATADIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq/Clean_Paired"
REFD=/hosted/biosc/SchwartzLab/ReferenceGenomes/ZebraFinch/NCBI/ncbi_dataset/data/HiSat2_Index_NCBI_RefSeq_GCF_048771995.1          
REF=ZF_NCBI_GCF_048771995.1_index 
MAPDIR="${HOMEDIR}/MAP_HISAT2"

###  use the sample IDs in the driver script
sample=$1


### Move to the directory where the data files are.
cd "$MAPDIR"

### BAM PROCESSING
 	### view: convert the SAM file into a BAM file  -bS: BAM is the binary format corresponding to the SAM text format.
  ### sort: convert the BAM file to a sorted BAM file.
  samtools view -@ 6 -bS "${sample}.sam" > "${sample}.bam"  
  
  ###  This is sorting the bam, using 6 threads, and producing a .bam file that includes the word 'sorted' in the name
  samtools sort -@ 6  "${sample}.bam"  -o  "${sample}_sorted.bam"

  ### Index the BAM and get mapping statistics, and put them in a text file for us to look at.
  samtools flagstat   "${sample}_sorted.bam"   > "${sample}_Stats.txt"
