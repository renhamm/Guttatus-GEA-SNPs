#!/bin/bash
#SBATCH --job-name=LD-plink
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD/LD-plink.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD/LD-plink.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD
module load python


~/Plink-files/plink --vcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --make-bed --const-fid 0 --allow-extra-chr --out G4t90_327 

~/Plink-files/plink --bfile G4t90_327 --r2 --ld-window-r2 0 --ld-window 99999 --allow-extra-chr --out G4t90_327 
