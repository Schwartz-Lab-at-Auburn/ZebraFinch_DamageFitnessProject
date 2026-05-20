#!/bin/bash

#SBATCH --job-name=ZFliver_BAM-Count
#SBATCH --time=1-00:00:00
#SBATCH --mail-user=aza0352@auburn.edu
#SBATCH --mail-type=ALL
#SBATCH --output=BAMCount%A-%a.out
#SBATCH --error=BAMCount%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --partition=general
#SBATCH --array=0-69   # match the number of samples

# Sample list
samples=(
    ZF_4529_D_L  ZF_4554_D_L  ZF_4620_D_L  ZF_4715_D_L  ZF_4739_D_L  ZF_4755_D_L  ZF_4773_D_L  ZF_4792_D_L  ZF_4806_D_L
    ZF_4530_D_L  ZF_4562_D_L  ZF_4622_D_L  ZF_4717_D_L  ZF_4741_D_L  ZF_4756_D_L  ZF_4779_D_L  ZF_4793_D_L  ZF_4808_D_L
    ZF_4531_D_L  ZF_4593_D_L  ZF_4625_D_L  ZF_4718_D_L  ZF_4744_D_L  ZF_4757_D_L  ZF_4781_D_L  ZF_4795_D_L  ZF_4809_D_L
    ZF_4533_D_L  ZF_4600_D_L  ZF_4703_D_L  ZF_4720_D_L  ZF_4745_D_L  ZF_4764_D_L  ZF_4782_D_L  ZF_4796_D_L  ZF_4812_D_L
    ZF_4534_D_L  ZF_4601_D_L  ZF_4704_D_L  ZF_4723_D_L  ZF_4748_D_L  ZF_4765_D_L  ZF_4783_D_L  ZF_4797_D_L  ZF_4814_D_L
    ZF_4543_D_L  ZF_4604_D_L  ZF_4705_D_L  ZF_4725_D_L  ZF_4749_D_L  ZF_4767_D_L  ZF_4784_D_L  ZF_4800_D_L  ZF_4817_D_L
    ZF_4548_D_L  ZF_4613_D_L  ZF_4708_D_L  ZF_4729_D_L  ZF_4752_D_L  ZF_4770_D_L  ZF_4785_D_L  ZF_4801_D_L
    ZF_4552_D_L  ZF_4619_D_L2  ZF_4712_D_L  ZF_4738_D_L  ZF_4753_D_L  ZF_4771_D_L2  ZF_4788_D_L  ZF_4805_D_L
)

sample_id=${samples[$SLURM_ARRAY_TASK_ID]}

# Keep all original directories
HOMEDIR=/scratch/aza0352/ZebraFinch_LiverRNAseq
DATADIR=/hosted/biosc/SchwartzLab/RNAseqData/ZebraFinch/AHDB/EXP1/Liver/01.RawData
QCDATA="${HOMEDIR}/QC/FastQC_raw"
CLDATADIR="${HOMEDIR}/Clean_Paired"
CLQCDATA="${HOMEDIR}/QC/FastQC_CLEAN"
REFD=/hosted/biosc/SchwartzLab/ReferenceGenomes/ZebraFinch/NCBI/ncbi_dataset/data/HiSat2_Index_NCBI_RefSeq_GCF_048771995.1
REF=ZF_NCBI_GCF_048771995.1_index
MAPDIR="${HOMEDIR}/MAP_HISAT2"
COUNTSDIR="${HOMEDIR}/COUNTS"

# Load required modules
module load gcc/4.8.5/samtools/1.20
module load stringtie/2.1.6

ulimit -s unlimited
set -x

# Move to script directory
cd /home/aza0352/RNAseqScripts || { echo "Cannot cd to script directory"; exit 1; }

# Run only BAM processing and StringTie counting
./4_BAM_PROCESSING.sh "$sample_id"
./5_COUNT-StringTie.sh "$sample_id"

