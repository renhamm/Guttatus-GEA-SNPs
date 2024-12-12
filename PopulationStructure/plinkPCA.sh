#!/bin/bash 
#SBATCH -J plinkPCA
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/plinkPCA.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/plinkPCA.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/plinkPCA 

module load python



~/Plink-files/plink --vcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.vcf.gz --double-id --pca --allow-extra-chr --out G4t90_327




