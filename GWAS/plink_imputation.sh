#!/bin/bash
#SBATCH --job-name=plinkImputation
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=3
#SBATCH --ntasks=1
#SBATCH --time=38:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/plinkImputation.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/plinkImputation.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink


#~/Plink-files/plink --bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/G4t90_327_LD0.2_maf9_maxmaf318_chrRename.vcf --genome --allow-no-sex --recode --out G4t90_327_LD0.2_maf9_maxmaf318_chrRename.vcf.imputed

~/Plink-files/plink --bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/new2.14chrs.altallele9indv-max318.recode.chrRename.vcf --genome --allow-no-sex --recode --out new2.14chrs.altallele9indv-max318.recode.chrRename.vcf.imputed

