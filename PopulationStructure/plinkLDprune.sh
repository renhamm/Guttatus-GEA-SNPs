#!/bin/bash 
#SBATCH -J LDprune
#SBATCH --account=co_rosalind
#SBATCH --partition=savio4_htc
#SBATCH --qos=savio_lowprio
#SBATCH --cpus-per-task=2
#SBATCH --time=72:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/LDprune.out
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure/err_out/LDprune.err
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All


cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/PopStructure

module load python


#make bim/fam/bed
~/Plink-files/plink --allow-extra-chr --vcf /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/GATK_files/combined_vcfs/GEAsamples.cohort.VQSR.G4t90_327.removed.biallelicsnps.14chrs.vcf.gz \
       --keep-allele-order \
       --const-fid 0 \
       --make-bed \
--out G4t90_327_14chr_plinked

~/Plink-files/plink --allow-extra-chr --bfile G4t90_327_14chr_plinked \
--indep-pairwise 20 1 0.2 \
       --out G4t90_327_14chr_LD0.2_1step_20window
#makes prune.in file

~/Plink-files/plink --allow-extra-chr --bfile G4t90_327_14chr_plinked \
--extract G4t90_327_14chr_LD0.2_1step_20window.prune.in \
--make-bed --out G4t90_327_14chr_plinked_LD0.2_1step_20window_Pruned
#makes bim file that takes prune.in and extracts it from bim

#converts bim to vcf
~/Plink-files/plink --bfile G4t90_327_14chr_plinked_LD0.2_1step_20window_Pruned --recode vcf-iid --allow-extra-chr --out G4t90_327_14chr_pruned0.2.vcf

