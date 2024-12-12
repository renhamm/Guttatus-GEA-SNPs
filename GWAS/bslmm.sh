#!/bin/bash
#SBATCH --job-name=bslmm
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=6
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/bslmm.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/bslmm.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

export MODULEPATH=/clusterfs/vector/home/groups/software/sl-7.x86_64/modfiles:$MODULEPATH
module load gcc gsl r python openblas gemma 
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/global/home/groups/consultsw/sl-7.x86_64/modules/gsl/2.0/lib/
export LC_CTYPE=en_US.UTF-8

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files

#RUN ONE
for f in *fullRange.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 471471 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_1_$v_name ; done

for f in *ORblue.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 471471 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_1_$v_name ; done

for f in *NoCAgreen.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 471471 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_1_$v_name ; done

for f in *SoCAred.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 471471 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_1_$v_name ; done 



#RUN TWO
for f in *fullRange.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 222111 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_2_$v_name ; done

for f in *ORblue.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 222111 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_2_$v_name ; done

for f in *NoCAgreen.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 222111 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_2_$v_name ; done

for f in *SoCAred.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 222111 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_2_$v_name ; done


#RUN THREE
for f in *fullRange.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 987654 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_3_$v_name ; done

for f in *ORblue.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 987654 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_3_$v_name ; done

for f in *NoCAgreen.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 987654 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_3_$v_name ; done

for f in *SoCAred.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 987654 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_3_$v_name ; done


#RUN FOUR
for f in *fullRange.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 302010 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_4_$v_name ; done

for f in *ORblue.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_ORblue.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 302010 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_4_$v_name ; done

for f in *NoCAgreen.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_NoCAgreen.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 302010 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_4_$v_name ; done

for f in *SoCAred.txt; do v_name=${f%.txt}; gemma -bfile /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.vcf.recode.vcf.imputed -k /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/plink/output/new2.14chrs.altallele9indv-max318.recode.chrRename_SoCAred.imputed_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -bslmm 1 -seed 302010 -w 5000000 -s 25000000 -rpace 1000 -wpace 10000 -o imputed_4_$v_name ; done




























