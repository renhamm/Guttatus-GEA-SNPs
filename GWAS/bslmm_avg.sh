#!/bin/bash 
#SBATCH -J bslmmAvg
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/bslmmAvg.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/bslmmAvg.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/bslmm/output
module load r


#running Rscript
Rscript --no-save /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/scripts/GWAS/bslmm_avg_script.R



