#!/bin/bash
#SBATCH --job-name=TajD-vcftools
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/TajD-vcftools.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/TajD-vcftools.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats

module load bio/vcftools


for pop in `ls indv-pops/indvlists/*-only.txt | cut -d"/" -f3 | rev | cut -d"-" -f2- | rev`; do
	vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/construct/subVCFs/G4t90/array/GEAsamples.cohort.VQSR.G4t90.removed.biallelicsnps."$pop"-only.vcf.gz --TajimaD 10000 --out TajD/"$pop"-G4t90
	done
