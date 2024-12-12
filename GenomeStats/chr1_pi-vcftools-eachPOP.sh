#!/bin/bash
#SBATCH --job-name=pi-chr1
#SBATCH --account=co_rosalind
#SBATCH --partition=savio4_htc
#SBATCH --qos=savio_lowprio
#SBATCH --cpus-per-task=3
#SBATCH --ntasks=1
#SBATCH --time=72:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/pi-chr1-vcftools.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/pi-chr1-vcftools.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats

module load bio/vcftools


for pop in `ls indv-pops/indvlists/*-only.txt | cut -d"/" -f3 | rev | cut -d"-" -f2- | rev`; do
	vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/indvChrFiles/chr1_invar_bcftools.vcf.gz --site-pi --keep /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/indv-pops/indvlists/"$pop"-only.txt --out pi-stats/"$pop"_chr1
	done
