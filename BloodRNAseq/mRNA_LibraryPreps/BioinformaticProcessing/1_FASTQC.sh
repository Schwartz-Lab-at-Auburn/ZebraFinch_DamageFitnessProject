#!/bin/bash

HOMEDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"
DATADIR="/hosted/biosc/SchwartzLab/RNAseqData/ZebraFinch/AHDB/EXP1/All_Blood_mRNA_namesConsistent"
QCDATA="${HOMEDIR}/QC/FastQC_raw"

###  use the sample IDs in the driver script
sample=$1

### Make the output directory
mkdir -p $QCDATA

### Move to the directory where the data files are.
cd "$DATADIR"


################## Run FASTQC to assess the quality of the data
fastqc -t 20 "${sample}_1.fq.gz" "${sample}_2.fq.gz" --outdir=$QCDATA
