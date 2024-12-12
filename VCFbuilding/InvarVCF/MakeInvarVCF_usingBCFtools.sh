#!/bin/bash 
#SBATCH -J invarVCF
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/makeInvarVCF_bcftools.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/makeInvarVCF_bcftools.err 
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/indvChrFiles 
module load bcftools


bcftools mpileup -f /global/scratch/users/laurenhamm/thesis/ref-genomes/v3_mt-cs/Mgut_v3_mt-cs.fa -b /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts/bamList4bcftools.txt -r Chr_01 | bcftools call -m -Oz -f GQ -o chr1_invar_bcftools.vcf.gz


