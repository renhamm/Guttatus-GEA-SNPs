#!/bin/bash
#SBATCH --job-name=TajD-vcftools
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/TajD-vcftools-regions.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/TajD-vcftools-regions.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats
export MODULEPATH=/clusterfs/vector/home/groups/software/sl-7.x86_64/modfiles:$MODULEPATH
module load bio/vcftools


vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --keep /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/ORindv.txt --TajimaD 1000 --out /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/eachRegion/ORblue

vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --keep /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/NoCAindv.txt --TajimaD 1000 --out /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/eachRegion/NoCAgreen

vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz --keep /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/SoCAindv.txt --TajimaD 1000 --out /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/TajD/eachRegion/SoCAred



