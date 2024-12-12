#!/bin/bash 
#SBATCH -J tstv1
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=72:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/hard_filtered/snpSift-redo_generated-output.txt
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/hard_filtered/SnpSift-redo_generated-error.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/hard_filtered

module load java

java -jar /global/home/users/laurenhamm/snpEff/SnpSift.jar tstv /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/hard_filtered/GEAsamples.cohort.snps_filtered_removed.vcf.gz
