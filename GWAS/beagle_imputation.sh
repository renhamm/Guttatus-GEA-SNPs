#!/bin/bash
#SBATCH --job-name=beagle
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=3
#SBATCH --ntasks=1
#SBATCH --time=38:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/beagleImputation.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/beagleImputation.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

module load java  
cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/beagle


java -jar /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/software/beagle.06Aug24.a91.jar gt=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/new2.14chrs.altallele9indv-max318.recode.vcf out=MAF9_fullRange.gt

