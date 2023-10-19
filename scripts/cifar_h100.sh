#!/bin/bash
#SBATCH --partition=camas  ### Partition
#SBATCH --job-name=cifarlt  ### Job Name
#SBATCH --time=16:00:00      ### WallTime
#SBATCH --nodes=1            ### Number of Nodes
#SBATCH --ntasks-per-node=4 ### Number of tasks (MPI processes)
##SBATCH --mem=350000 	### Memory(MB)

module load python3/3.11.4
cd $MYSCRATCH
source $MYSCRATCH/env4t22/bin/activate
cd $MYSCRATCH/ACE-SAM
# =======
#  Step1
# =======
Lm=( 0.5 )
F0=( 0.5 0.6 0.7 0.8 )
for lam in "${Lm[@]}" ; 
do
	for f0 in "${F0[@]}" ; 
	do
		time python test_cifar.py --config=./configs/Cifar100.json --work=train --clambda=$lam --f0=$f0
		time python test_cifar.py --config=./configs/Cifar100.json --work=test --clambda=$lam --f0=$f0
	done	
done
