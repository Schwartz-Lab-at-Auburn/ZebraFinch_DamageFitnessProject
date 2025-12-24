#!/bin/bash

HOMEDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"
DATADIR="/hosted/biosc/SchwartzLab/RNAseqData/ZebraFinch/AHDB/EXP1/All_Blood_mRNA_namesConsistent"
CLDATADIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq/Clean_Paired"
CLQCDATA="${HOMEDIR}/QC/FastQC_CLEAN"

###  use the sample IDs in the driver script
sample=$1

### Make the output directory
mkdir -p "$CLQCDATA"

### Move to the directory where the data files are.
cd "$CLDATADIR"

################## Run FASTQC to assess the quality of the data
fastqc -t 20 "${sample}_1_paired.fq.gz" "${sample}_2_paired.fq.gz" --outdir="$CLQCDATA"
