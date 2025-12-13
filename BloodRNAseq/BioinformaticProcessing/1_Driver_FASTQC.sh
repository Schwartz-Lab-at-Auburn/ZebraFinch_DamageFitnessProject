#!/bin/bash

#SBATCH --job-name=FASTQC              #-- For convenience, give your job a name
#SBATCH --time 96:00:00                         #-- The format is DD-HH:MM:SS.  #estimated wall time in which to run your job
#SBATCH --mail-user tss0019@auburn.edu          #-- Indicate if/when you want to receive email about your job
#SBATCH --mail-type=ALL                         #-- will send email for begin,end,fail
#SBATCH --output=Map%A-%a.out   #-- Changes the output to correspond to each subjob
#SBATCH --error=Map%A-%a.err    #-- Changes the error to correspond to each subjob
#SBATCH --nodes=1                               #-- Specify the number of nodes and cores you want to use. Standard nodes 20 core
#SBATCH --ntasks=20                             #-- processors requested
#SBATCH --partition=general
#SBATCH --array=0-98

samples=(ZF_4529_D_BL
ZF_4530_D_BL
ZF_4531_B_BL
ZF_4531_D_BL
ZF_4533_B_BL
ZF_4533_D_BL
ZF_4533_H_BL
ZF_4534_D_BL
ZF_4543_D_BL
ZF_4548_B_BL
ZF_4548_D_BL
ZF_4548_H_BL
ZF_4552_D_BL
ZF_4554_D_BL
ZF_4562_D_BL
ZF_4593_D_BL
ZF_4600_D_BL
ZF_4601_D_BL
ZF_4604_D_BL
ZF_4613_D_BL
ZF_4619_B_BL
ZF_4619_D_BL
ZF_4619_H_BL
ZF_4620_D_BL
ZF_4622_D_BL
ZF_4625_B_BL
ZF_4625_D_BL
ZF_4625_H_BL
ZF_4703_D_BL
ZF_4704_D_BL
ZF_4705_D_BL
ZF_4708_D_BL
ZF_4712_D_BL
ZF_4715_D_BL
ZF_4717_D_BL
ZF_4718_D_BL
ZF_4719_B_BL
ZF_4720_B_BL
ZF_4720_D_BL
ZF_4723_D_BL
ZF_4725_D_BL
ZF_4729_D_BL
ZF_4737_B_BL
ZF_4738_B_BL
ZF_4738_D_BL
ZF_4738_H_BL
ZF_4739_B_BL
ZF_4739_D_BL
ZF_4739_H_BL
ZF_4741_D_BL
ZF_4744_D_BL
ZF_4745_B_BL
ZF_4745_D_BL
ZF_4745_H_BL
ZF_4748_D_BL
ZF_4749_D_BL
ZF_4752_D_BL
ZF_4753_D_BL
ZF_4755_D_BL
ZF_4756_D_BL
ZF_4757_D_BL
ZF_4761_B_BL
ZF_4764_D_BL
ZF_4765_D_BL
ZF_4767_D_BL
ZF_4768_B_BL
ZF_4770_D_BL
ZF_4771_D_BL
ZF_4774_B_BL
ZF_4775_B_BL
ZF_4779_D_BL
ZF_4781_D_BL
ZF_4782_D_BL
ZF_4783_D_BL
ZF_4784_B_BL
ZF_4784_D_BL
ZF_4784_H_BL
ZF_4785_B_BL
ZF_4785_D_BL
ZF_4785_H_BL
ZF_4788_D_BL
ZF_4792_D_BL
ZF_4793_D_BL
ZF_4795_D_BL
ZF_4796_D_BL
ZF_4797_D_BL
ZF_4798_B_BL
ZF_4800_D_BL
ZF_4801_D_BL
ZF_4802_B_BL
ZF_4805_D_BL
ZF_4806_D_BL
ZF_4808_D_BL
ZF_4809_D_BL
ZF_4810_B_BL
ZF_4812_D_BL
ZF_4814_D_BL
ZF_4817_B_BL
ZF_4817_D_BL)

sample_id=${samples[$SLURM_ARRAY_TASK_ID]}

PROJDIR="/scratch/tss0019/ZebraFinch_AllBloodRNAseq"

# __________________________

#--Load modules needed for job
module load fastqc/0.12.0

#  Set the stack size to unlimited
ulimit -s unlimited

#  Turn echo on so all commands are echoed in the output log
set -x

### Make sure we're in the same directory as the scripts
cd /home/tss0019/ZebraFinch_AllBlood

############# Run FASTQC
./1_FASTQC.sh "$sample_id"

## Submit this command to run the driver!
#--  sbatch 1_Driver_Fastqc.sh
