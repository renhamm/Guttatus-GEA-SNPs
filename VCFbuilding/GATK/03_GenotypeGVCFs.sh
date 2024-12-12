#!/bin/bash 
#SBATCH -J GenotypeGVCFs
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GATK-GG_generated-output.txt
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GATK-GG_generated-error.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs 
module load java
module load python
source activate gatk


/global/scratch/users/laurenhamm/thesis/software/gatk/gatk --java-options "-Xmx4g" GenotypeGVCFs \
   -R /global/scratch/users/laurenhamm/thesis/ref-genomes/v3_mt-cs/Mgut_v3_mt-cs.fa \
   -V GEAsamples.cohort.g.vcf.gz \
   -O GEAsamples.cohort.vcf.gz \
   --heterozygosity 0.2 \
   --max-alternate-alleles 1 \




