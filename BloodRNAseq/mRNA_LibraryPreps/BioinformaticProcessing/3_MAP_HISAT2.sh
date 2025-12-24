#!/bin/bash

HOMEDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"
CLDATADIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq/Clean_Paired"
REFD=/hosted/biosc/SchwartzLab/ReferenceGenomes/ZebraFinch/NCBI/ncbi_dataset/data/HiSat2_Index_NCBI_RefSeq_GCF_048771995.1          
REF=ZF_NCBI_GCF_048771995.1_index 
MAPDIR="${HOMEDIR}/MAP_HISAT2"

###  use the sample IDs in the driver script
sample=$1

### Make the output directory
mkdir -p $MAPDIR

### Move to the directory where the data files are.
cd "$CLDATADIR"

### Map the Data
 hisat2 -p 6 --dta --phred33       \
    -x "${REFD}"/"${REF}"       \
    -1 "${sample}_1_paired.fq.gz"  -2 "${sample}_2_paired.fq.gz"     \
    -S "${MAPDIR}"/"${sample}.sam"
