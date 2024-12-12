#!/bin/bash
#SBATCH --job-name=PaleoInputs
#SBATCH --account=ac_acblackman
#SBATCH --partition=savio3_htc
#SBATCH --qos=savio_normal
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=72:00:00
#SBATCH --error=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/paleomixInput_error.txt
#SBATCH --output=/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/paleomix/paleomixInput_output.txt
#SBATCH --mail-user=laurenhamm@berkeley.edu
#SBATCH --mail-type=All

cd /global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/fastq_original

counter=1

#loops though list of individuals and replaces random string code with specialized input string notation

for f in *1.fastq; do IndvName=${f%_1.fastq}; IndvFix=${f%_1.fastq}_ ; sed -e "s@ReplaceInput$counter-@\n\n$IndvName:\n $IndvName:\n   $IndvName:\n     Lane1: \"/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/fastq_original/$IndvFix\{Pair\}.fastq\"@g" ../paleomix/old_yaml/paleomix_65_input1_ReplaceName.yaml > ${IndvName}.temp ; cp ${IndvName}.temp ../paleomix/old_yaml/paleomix_65_input1_ReplaceName.yaml; let counter=counter+1; done

for f in *R1.fastq.gz; do IndvName=${f%-R1.fastq.gz}; sed -e "s@ReplaceInput$counter-@\n\n$IndvName:\n $IndvName:\n   $IndvName:\n     Lane1: \"/global/scratch/users/laurenhamm/thesis/aim1/Alignment_v3/fastq_original/$IndvName-R\{Pair\}.fastq.gz\"\n\n@g" ../paleomix/old_yaml/paleomix_65_input1_ReplaceName.yaml > ${IndvName}.temp ; cp ${IndvName}.temp ../paleomix/old_yaml/paleomix_65_input1_ReplaceName.yaml; let counter=counter+1 ; done

