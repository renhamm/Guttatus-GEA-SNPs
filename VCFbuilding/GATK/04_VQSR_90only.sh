#!/bin/bash 
#SBATCH -J VQSR-90only
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --time=400:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/err_out/GATK-VQSRrep.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/err_out/GATK-VQSRrep.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs 
module load java
module load python
source activate gatk
module load r 
module load r-packages

#making sites-only vcf, removes superfluous columns
/global/scratch/users/laurenhamm/thesis/software/gatk/gatk --java-options "-Xmx4g" MakeSitesOnlyVcf \
      INPUT=GEAsamples.cohort.vcf.gz \
      OUTPUT=GEAsamples.cohort.sites.vcf.gz

#training model and creating VQSLOD scores
/global/scratch/users/laurenhamm/thesis/software/gatk/gatk --java-options "-Xmx64g" VariantRecalibrator \
    -V GEAsamples.cohort.sites.vcf.gz \
    --trust-all-polymorphic \
    -tranche 90.0 \
    -an QD -an MQRankSum -an ReadPosRankSum -an FS -an MQ -an SOR -an DP \
    -mode SNP \
    --max-gaussians 4 \
    --resource:Mgut_TruthSet,known=false,training=true,truth=true,prior=15 GEAsamples.TruthSet.filtered.removed.vcf.gz \
    -O VQSR_outputs/90only/GEAsamples.cohort_snps.recal \
    --tranches-file VQSR_outputs/90only/G4t90.GEAsamples.cohort_snps.tranches \
    --rscript-file VQSR_outputs/90only/G4t90_recalibrate_SNP_plots.R  

#applying threshold filter
/global/scratch/users/laurenhamm/thesis/software/gatk/gatk --java-options "-Xmx64g" ApplyVQSR \
   -R /global/scratch/users/laurenhamm/thesis/ref-genomes/v3_mt-cs/Mgut_v3_mt-cs.fa \
   -V GEAsamples.cohort.vcf.gz \
   -O GEAsamples.cohort.VQSRfiltered.vcf.gz \
   --truth-sensitivity-filter-level 99.0 \
   --tranches-file GEAsamples.cohort_snps.tranches \
   --recal-file GEAsamples.cohort_snps.recal \
   -mode SNP

 
