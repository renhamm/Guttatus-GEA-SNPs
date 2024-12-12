#!/bin/bash
#SBATCH --job-name=inputGWAS
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_htc
#SBATCH --qos=savio_lowprio
#SBATCH --cpus-per-task=3
#SBATCH --ntasks=1
#SBATCH --time=72:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/GWAS_input.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/GWAS_input.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

module load bio/vcftools
cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma

vcftools --vcf new2.14chrs.altallele9indv-max318.recode.chrRename.vcf --plink --out new2.14chrs.altallele9indv-max318.recode.chrRename.vcf


