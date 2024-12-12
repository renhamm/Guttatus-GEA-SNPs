#!/bin/bash
#SBATCH --job-name=pi-vcftools
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/pi-vcftools.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/pi-vcftools.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats

module load bio/vcftools


for pop in `ls indv-pops/indvlists/*-only.txt | cut -d"/" -f3 | rev | cut -d"-" -f2- | rev`; do
	vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK/combined_vcfs/GEAsamples.cohort.invar.vcf.gz --site-pi --keep /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/indv-pops/indvlists/"$pop"-only.txt --out pi-stats/"$pop"-invar
	done
