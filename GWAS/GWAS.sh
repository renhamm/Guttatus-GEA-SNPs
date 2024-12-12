#!/bin/bash
#SBATCH --job-name=GWAS
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_htc
#SBATCH --qos=savio_lowprio
#SBATCH --cpus-per-task=3
#SBATCH --ntasks=1
#SBATCH --time=72:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/GWAS.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/err_out/GWAS.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

module load gcc r python/2.7 blas openblas gsl zlib lapack
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/global/home/groups/consultsw/sl-7.x86_64/modules/gsl/2.0/lib/
export LC_CTYPE=en_US.UTF-8

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma


#only 14 chrs
#module load bio/vcftools
#vcftools --vcf new2.14chrs.altallele9indv-max318.recode.chrRename.beforeChrPrune.vcf --chr 1 --chr 2 --chr 3 --chr 4 --chr 5 --chr 6 --chr 7 --chr 8 --chr 9 --chr 10 --chr 11 --chr 12 --chr 13 --chr 14 --recode --out new2.14chrs.altallele9indv-max318.recode.chrRename 


#get bed/bim/fam
#~/Plink-files/plink --vcf new2.14chrs.altallele9indv-max318.recode.chrRename.vcf --make-bed --out new2.14chrs.altallele9indv-max318.recode.chrRename.vcf 
#sed -i -e 's/-9/1/g' new2.14chrs.altallele9indv-max318.recode.chrRename.vcf.fam

# compute Kinship matrix
#~/GEMMA-0.98.5/bin/gemma -bfile new2.14chrs.altallele9indv-max318.recode.chrRename.vcf -gk 2 -o new2.14chrs.altallele9indv-max318.recode.chrRename_kinship   



cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files

#runGWAS
for f in *.txt; do v_name=${f%.txt}; cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/$v_name;  ~/GEMMA-0.98.5/bin/gemma -bfile ../new2.14chrs.altallele9indv-max318.recode.chrRename.vcf -k ../new2.14chrs.altallele9indv-max318.recode.chrRename_kinship.sXX.txt -p /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GWAS_gemma/phenotype_files/$f -c ../covariates.tsv -lmm 4 -o ../$v_name ; done




