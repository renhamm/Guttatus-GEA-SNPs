#!/bin/bash
#SBATCH --job-name=fst
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/fst/fst.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/fst/fst.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/fst

module load bio/vcftools


vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --weir-fst-pop ../ORindv.txt --weir-fst-pop ../NoCAindv.txt --out OR-NoCA

vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --weir-fst-pop ../ORindv.txt --weir-fst-pop ../SoCAindv.txt --out OR-SoCA

vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --weir-fst-pop ../NoCAindv.txt --weir-fst-pop ../SoCAindv.txt --out NoCA-SoCA 










