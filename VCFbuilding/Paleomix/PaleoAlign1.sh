#!/bin/bash 
#SBATCH -D /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts
#SBATCH -J 1paleomix_330
#SBATCH --account=fc_blackman
#SBATCH --partition=savio3
#SBATCH --qos=savio_normal
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=3
#SBATCH --time=72:00:00
#SBATCH --mem=32000
#SBATCH -o /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/paleomix_330_1error.txt
#SBATCH -e /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/paleomix_330_1output.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

module load python
source activate paleomix

#module load bio/picard/2.9.0

paleomix bam_pipeline run /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/inputFiles/paleomix_330_1.yaml --max-threads $SLURM_CPUS_PER_TASK --jre-option=-Xmx10g --adapterremoval-max-threads 12 --bwa-max-threads 12 --destination=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/bamOuts --temp-root=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/fastq_original
