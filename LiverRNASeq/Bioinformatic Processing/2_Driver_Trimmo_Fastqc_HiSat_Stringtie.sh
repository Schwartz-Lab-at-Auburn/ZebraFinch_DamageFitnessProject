#!/bin/bash

#SBATCH --job-name=ZFliver_driver2              #-- For convenience, give your job a name
#SBATCH --time 5-00:00:00                      #-- The format is DD-HH:MM:SS.  #estimated wall time in which to run your job
#SBATCH --mail-user aza0352@auburn.edu          #-- Indicate if/when you want to receive email about your job
#SBATCH --mail-type=ALL                         #-- will send email for begin,end,fail
#SBATCH --output=Map%A-%a.out                   #-- Changes the output to correspond to each subjob
#SBATCH --error=Map%A-%a.err                    #-- Changes the error to correspond to each subjob
#SBATCH --nodes=1                               #-- Specify the number of nodes and cores you want to use. Standard nodes 20 core
#SBATCH --ntasks=6                              #-- processors requested per node
#SBATCH --partition=general			          #-- or use "general"
#SBATCH --array=0-69					 #-- This should match the number of files. Remember 0 counts as a node. So 0-98 will run 99 jobs

samples=(
    ZF_4529_D_L  ZF_4554_D_L  ZF_4620_D_L  ZF_4715_D_L  ZF_4739_D_L  ZF_4755_D_L  ZF_4773_D_L  ZF_4792_D_L  ZF_4806_D_L
    ZF_4530_D_L  ZF_4562_D_L  ZF_4622_D_L  ZF_4717_D_L  ZF_4741_D_L  ZF_4756_D_L  ZF_4779_D_L  ZF_4793_D_L  ZF_4808_D_L
    ZF_4531_D_L  ZF_4593_D_L  ZF_4625_D_L  ZF_4718_D_L  ZF_4744_D_L  ZF_4757_D_L  ZF_4781_D_L  ZF_4795_D_L  ZF_4809_D_L
    ZF_4533_D_L  ZF_4600_D_L  ZF_4703_D_L  ZF_4720_D_L  ZF_4745_D_L  ZF_4764_D_L  ZF_4782_D_L  ZF_4796_D_L  ZF_4812_D_L
    ZF_4534_D_L  ZF_4601_D_L  ZF_4704_D_L  ZF_4723_D_L  ZF_4748_D_L  ZF_4765_D_L  ZF_4783_D_L  ZF_4797_D_L  ZF_4814_D_L
    ZF_4543_D_L  ZF_4604_D_L  ZF_4705_D_L  ZF_4725_D_L  ZF_4749_D_L  ZF_4767_D_L  ZF_4784_D_L  ZF_4800_D_L  ZF_4817_D_L
    ZF_4548_D_L  ZF_4613_D_L  ZF_4708_D_L  ZF_4729_D_L  ZF_4752_D_L  ZF_4770_D_L  ZF_4785_D_L  ZF_4801_D_L
ZF_4552_D_L  ZF_4619_D_L  ZF_4712_D_L  ZF_4738_D_L  ZF_4753_D_L  ZF_4771_D_L  ZF_4788_D_L  ZF_4805_D_L
)

sample_id=${samples[$SLURM_ARRAY_TASK_ID]}

# __________________________ 
##-- Define PATHS. These need to be defined in the indivividual scripts too.

HOMEDIR=/scratch/aza0352/ZebraFinch_LiverRNAseq
DATADIR=/hosted/biosc/SchwartzLab/RNAseqData/ZebraFinch/AHDB/EXP1/All_Liver_mRNA_namesConsistent
QCDATA="${HOMEDIR}/QC/FastQC_raw"
CLDATADIR="${HOMEDIR}/Clean_Paired"
CLQCDATA="${HOMEDIR}/QC/FastQC_CLEAN"
REFD=/hosted/biosc/SchwartzLab/ReferenceGenomes/ZebraFinch/NCBI/ncbi_dataset/data/HiSat2_Index_NCBI_RefSeq_GCF_048771995.1        
REF=ZF_NCBI_GCF_048771995.1_index 
MAPDIR="${HOMEDIR}/MAP_HISAT2"
COUNTSDIR="${HOMEDIR}/COUNTS"


# __________________________
#--Load modules needed for job

module load fastqc/0.12.0
#module load python/anaconda/3.11.7   # Needed for Mutliqc
module load trimmomatic/0.39
module load gcc/4.8.5/samtools/1.20 # gcc needed for SamTools
module load hisat2/2.2.1
module load stringtie/2.1.6

###  Set the stack size to unlimited
ulimit -s unlimited
###  Turn echo on so all commands are echoed in the output log
set -x

# __________________________
#-- Runs Scripts

### Make sure we're in the same directory as the scripts
cd /home/aza0352/ZebraFinch_DamageFitnessProject/LiverRNASeq

############# Run Trimmomatic to clean the data
./2_TRIMMO.sh "$sample_id"

############# Run FASTQC (Again on the clean data)
./2.5_FASTQC-POST.sh "$sample_id"

### Run Multiqc to summarize the fastqc data - Run this seperately when FASTQC is finished for all samples
## multiqc "$CLQCDATA" -o "$CLQCDATA"
 
############# Run Mapping
./3_MAP_HISAT2.sh "$sample_id"

############# Run BAM Processing
./4_BAM_PROCESSING.sh "$sample_id"

############# Run Stringtime to count the reads mapped to each gene
./5_COUNT-StringTie.sh "$sample_id"

############# Complie the counts into a single file - Run this seperately when all jobs have finished.
 # run the python script prepDE.py3 to prepare the data for downstream analysis.
## python /hosted/biosc/SchwartzLab/useful_scripts_files/prepDE.py3 -i "${COUNTSDIR}"

# __________________________

## Submit this command to run the driver!
#--  sbatch 2_Driver_Trimmo_Fastqc_HiSat_Stringtie.sh
