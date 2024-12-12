#!/bin/bash
#SBATCH --job-name=LD-analysis
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD/LD-analysis.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD/LD-analysis.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/LD

#make ld files comma delimited
for f in Chr_*.ld; do cat $f | sed -r 's/ +/,/g' > $f.csv; done
#remove top line of every file but chr1 (gives error but works. use .temp files)
for f in *.csv; do sed '1d' $f > $f.temp; mv $f.tmp $f2.csv; done
#combine to one file
cat *.csv > allchr.ld
#thinning
cat G4t90_327.ld | sed 1,1d | awk -F "," 'function abs(v) {return v < 0 ? -v : v}BEGIN{OFS="\t"}{print abs($5-$3),$7}' | sort -k1,1n > WGthinned.ld.summary

#then export and continue in R

