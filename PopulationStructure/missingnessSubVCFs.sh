#!/bin/bash
#SBATCH --job-name=lmiss
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=72:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/missingness/G4t90-AF.%A_%a.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/missingness/G4t90-AF.%A_%a.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --array=1-113
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/construct/pop_lists

module load bio/vcftools

SAMPLE=`ls *indivlist.txt | head -n $SLURM_ARRAY_TASK_ID | tail -n 1` ;
PREFIX=`basename $SAMPLE -indivlist.txt` ;

vcftools --gzvcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/construct/subVCFs/G4t90/array/GEAsamples.cohort.VQSR.G4t90.removed.biallelicsnps."$PREFIX"-only.vcf.gz --missing-site --out /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/construct/subVCFs/G4t90/array/missingness/"$PREFIX"





