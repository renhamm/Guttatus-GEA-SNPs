#!/bin/bash
#SBATCH --job-name=pi-combine
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --cpus-per-task=5
#SBATCH --ntasks=1
#SBATCH --time=400:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/pi-combine.err
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats/pi-combine.out
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GenomeStats/pi-stats

#combining and averaging
for file in *-invar.sites.pi; do 
    filename=${file%-invar.sites.pi}
    cut -f3 $file > temp.txt
    sed -i -e "s/PI/$filename/g" temp.txt
    paste genloc.txt temp.txt > genloc1.txt
    mv genloc1.txt genloc.txt
done

mv genloc.txt USE_popPI_allChr_invar.txt
