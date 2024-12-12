#!/bin/bash 
#SBATCH -J Coverage
#SBATCH --account=co_rosalind
#SBATCH --partition=savio2_htc
#SBATCH --qos=rosalind_htc2_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --time=72:00:00
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts/Coverage/Coverage_generated-output.txt
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts/Coverage/Coverage_generated-error.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

export MODULEPATH=${MODULEPATH}:/clusterfs/vector/home/groups/software/sl-7.x86_64/modfiles
module load picard/2.9.0 
module load java

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts
for file in *.bam; \
    do seq_name=${file%.GEAsamples.bam}; \
    echo $seq_name 
    echo $file 
    java -jar /clusterfs/vector/home/groups/software/sl-7.x86_64/modules/picard/2.9.0/lib/picard.jar CollectWgsMetrics \
    I=${seq_name}.GEAsamples.bam \
    O=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts/Coverage/${seq_name}_CollectWgsMetrics.txt \
    R=/global/scratch/users/laurenhamm/thesis/ref-genomes/v3_mt-cs/Mgut_v3_mt-cs.fa; done
