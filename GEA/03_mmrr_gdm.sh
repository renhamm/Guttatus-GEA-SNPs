#!/bin/bash 
#SBATCH -J 03_mmrr_gdm
#SBATCH --account=fc_blackman
#SBATCH --partition=savio2_bigmem
#SBATCH --qos=savio_normal
#SBATCH --ntasks-per-node=1
#SBATCH --time=72:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/err_out/03_mmrr_gdm.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/err_out/03_mmrr_gdm.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/tess 
module load r/4.3.2 r-packages r-spatial/4.3
export LC_CTYPE=en_US.UTF-8

#running Rscript
Rscript --no-save /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/scripts/ALGATR/03_mmrr_gdm_script.R

#queueing next step
#sbatch 04_rda.txt


