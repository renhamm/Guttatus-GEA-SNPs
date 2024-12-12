#!/bin/bash 
#SBATCH -J LDdecay
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_xlmem
#SBATCH --qos=rosalind_xlmem3_normal
#SBATCH --ntasks-per-node=1
#SBATCH --time=72:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD/decay.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD/decay.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD 
module load r/4.3.2 r-packages r-spatial/4.3
export LC_CTYPE=en_US.UTF-8

#make input file with 2 columns (distance, r2)
echo "chr1,pos1,.,chr2,pos2,.,r2" | cat - allchr.ld.csv > allchr.ld.1.csv
awk -F',' 'BEGIN { OFS = "\t" } NR == 1 { $8 = "diff." } NR >= 3 { $8 = $5 - $2 } 1' < allchr.ld.1.csv > allchr_temp.txt
sed -i -e '2d' allchr_temp.txt
cut -f8 allchr_temp.txt > allchr_temp1.txt
cut -f7 allchr_temp.txt > allchr_temp2.txt
paste allchr_temp1.txt allchr_temp2.txt > allChr_decaystats.txt
awk -F: '$1<=20000' allChr_decaystats.txt > allChr_decaystats_pruned.txt


#running Rscript
R CMD BATCH --no-save /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/scripts/GenomeStats/LDdecay_script.R

