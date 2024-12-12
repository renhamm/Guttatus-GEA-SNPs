#!/bin/bash 
#SBATCH -J HaplotypeCaller
#SBATCH --account=fc_blackman
#SBATCH --partition=savio3_htc
#SBATCH --qos=savio_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=72:00:00
#SBATCH --array=1-330
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/indv_vcfs/error-output_files/GATK-HC_%A_%a_generated-output.txt
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/indv_vcfs/error-output_files/GATK-HC_%A_%a_generated-error.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts 
module load java
module load python
source activate gatk


SAMPLE=`ls *.bam | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`
PREFIX=`ls *.bam | head -n $SLURM_ARRAY_TASK_ID | tail -n 1 | cut -d"." -f1`

/global/scratch/users/laurenhamm/thesis/software/gatk/gatk --java-options "-Xmx64G" HaplotypeCaller\
    -R /global/scratch/users/laurenhamm/thesis/ref-genomes/v3_mt-cs/Mgut_v3_mt-cs.fa\
    -I /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts/${PREFIX}.GEAsamples.bam\
    -O /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/indv_vcfs/${PREFIX}.g.vcf.gz\
    -ERC GVCF\
    --min-base-quality-score 25 \
    --max-alternate-alleles 1 \
    -ploidy 2 \
    --heterozygosity 0.02\




echo "$SLURM_ARRAY_TASK_ID $PREFIX : completed" 



