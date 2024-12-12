#!/bin/bash 
#SBATCH -J WZA_200
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=240:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/WZA/err_out/WZA_200snps.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/WZA/err_out/WZA_200snps.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=ALL


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/WZA 
module load python


python3 general_WZA_script.py --correlations input_files/updated_finalWZAinput_200snps_FR.txt \
                              --summary_stat pval \
                              --window WINDOW \
                              --MAF maf \
                              --output updated_rda_fullRange_WZA_200snps.csv \

