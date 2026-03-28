#!/bin/sh
#SBATCH --cpus-per-task=8
#SBATCH --job-name=fastqc
#SBATCH --mem-per-cpu=1g
#SBATCH --time=07:00:00

# set up job environment
module load Java/11.0.27
module load FastQC/0.12.1-Java-11
module load parallel/20250722-GCCcore-14.2.0
# working folder: /scratch/brussel/vo/000/bvo00026/vsc10841/Mapping_RNAseq_heps_mono
cd /scratch/brussel/vo/000/bvo00026/vsc10841/Mapping_RNAseq_heps_mono
mkdir ./QC_RAW/
max_jobs=4

for i in /scratch/brussel/vo/000/bvo00026/vsc10841/RNAseq_heps_20260327/*.fastq.gz
do
 fastqc -o ./QC_RAW/ "$i" & 
 if [[ $(jobs -r -p | wc -l) -ge $max_jobs ]]; then
    wait -n
 fi
done
