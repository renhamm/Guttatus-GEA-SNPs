#!/bin/bash
#SBATCH --job-name=piAvg
#SBATCH --account=co_rosalind
#SBATCH --partition=savio3_htc
#SBATCH --qos=savio_lowprio
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --time=72:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/piAvg.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/piAvg.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats

for pop in `(ls *-invar.sites.pi | cut -d"-" -f1)`; do for f in "$pop"_*; do echo -e "$f\t$(awk '$3 == $3 && $3 != "-nan" { total += $3; count++ } END { if (count > 0) print total/count }' "$f")"; done >> "$pop"_chrAvgPi.txt; done
