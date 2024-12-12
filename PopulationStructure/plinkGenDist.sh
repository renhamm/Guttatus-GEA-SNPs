#!/bin/bash 
#SBATCH -J plinkGenDist
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/plinkGenDist.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/plinkGenDist.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure

module load python



~/Plink-files/plink --vcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --distance square --double-id --allow-extra-chr --out G4t90_327


