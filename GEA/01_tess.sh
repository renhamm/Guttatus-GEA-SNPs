#!/bin/bash 
#SBATCH -J 01_tess
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --ntasks-per-node=1
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/err_out/01_tess.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/err_out/01_tess.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/tess 
module load r/4.3.2 r-packages r-spatial/4.3
export LC_CTYPE=en_US.UTF-8

#running Rscript
Rscript --no-save /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/scripts/ALGATR/01_tess_script.R

#queueing next step
#sbatch 02_wingen.txt


