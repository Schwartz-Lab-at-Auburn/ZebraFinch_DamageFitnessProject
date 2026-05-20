#!/bin/bash

HOMEDIR="/scratch/aza0352/ZebraFinch_LiverRNAseq"
DATADIR="/hosted/biosc/SchwartzLab/RNAseqData/ZebraFinch/AHDB/EXP1/Liver/01.RawData"
CLDATADIR="/scratch/aza0352/ZebraFinch_LiverRNAseq/Clean_Paired"
CLQCDATA="${HOMEDIR}/QC/FastQC_CLEAN"

###  use the sample IDs in the driver script
sample=$1

### Make the output directory
mkdir -p "$CLQCDATA"

### Move to the directory where the data files are.
cd "$CLDATADIR"

################## Run FASTQC to assess the quality of the data
fastqc -t 20 "${sample}_1_paired.fq.gz" "${sample}_2_paired.fq.gz" --outdir="$CLQCDATA"
