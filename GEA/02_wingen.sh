#!/bin/bash 
#SBATCH -J 02_wingen
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/err_out/02_wingen.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/err_out/02_wingen.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/ALGATR/tess 
module load r/4.3.2 r-packages r-spatial/4.3


#running Rscript
Rscript --no-save /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/scripts/ALGATR/02_wingen_script.R

#queueing next step
#sbatch 03_mmr_gdm.txt


