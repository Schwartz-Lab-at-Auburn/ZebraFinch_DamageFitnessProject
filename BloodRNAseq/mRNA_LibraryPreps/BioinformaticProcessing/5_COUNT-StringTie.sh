#!/bin/bash

HOMEDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"
REFD=/hosted/biosc/SchwartzLab/ReferenceGenomes/ZebraFinch/NCBI/ncbi_dataset/data/HiSat2_Index_NCBI_RefSeq_GCF_048771995.1          
REF=ZF_NCBI_GCF_048771995.1_index 

MAPDIR="${HOMEDIR}/MAP_HISAT2"
COUNTSDIR="${HOMEDIR}/COUNTS"

###  use the sample IDs in the driver script
sample=$1

### Make the output directory
mkdir -p "$COUNTSDIR"

### Move to the directory where the data files are.
cd "$MAPDIR"


################## Run stringtie to count the reads mapped to the genes

mkdir "${COUNTSDIR}"/"${sample}"
stringtie -p 6 -e -B -G  "${REFD}"/ZF_NCBI_GCF_048771995.1.gtf  -o "${COUNTSDIR}"/"${sample}"/"${sample}.gtf"  -l "${sample}"  "${MAPDIR}"/"${sample}_sorted.bam"
