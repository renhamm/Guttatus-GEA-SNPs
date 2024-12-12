#!/bin/bash
#SBATCH --job-name=admix
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/admix.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/admix.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/admixture 
module load bcftools

bcftools annotate --rename-chrs chr_rename.txt GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz | bcftools convert -O z > G4t90_327.14chrs.rename.vcf.gz

bcftools annotate --rename-chrs chr_rename.txt G4t90_327.14chrs.vcf.gz | gzip > G4t90_327.14chrs.rename.vcf.gz


/global/home/users/laurenhamm/Plink-files/plink --vcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.rename.vcf.gz --make-bed --const-fid 0 --out /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.rename 



for K in 1 2 3 4 5 6 7 8 9 10; \
do ~/admixture_linux-1.3.0/admixture --cv /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.rename.bed $K | tee G4t90_327_log${K}.out; done

