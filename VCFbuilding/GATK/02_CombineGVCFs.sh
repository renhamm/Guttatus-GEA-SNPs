#!/bin/bash 
#SBATCH -J CombineGVCFs
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GATK-CG_generated-output.txt
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GATK-CG_generated-error.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/indv_vcfs 
module load java
module load python
source activate gatk


/global/scratch/users/laurenhamm/thesis/software/gatk/gatk --java-options "-Xmx64G" CombineGVCFs \
   -R /global/scratch/users/laurenhamm/thesis/ref-genomes/v3_mt-cs/Mgut_v3_mt-cs.fa \
   --variant ../indv_vcfs/input.list \
   -O ../combined_vcfs/GEAsamples.cohort.g.vcf.gz






