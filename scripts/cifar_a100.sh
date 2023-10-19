#!/bin/bash
#SBATCH --partition=tao  ### Partition
#SBATCH --job-name=cifarlt  ### Job Name
#SBATCH --time=12:00:00      ### WallTime
#SBATCH --nodes=1            ### Number of Nodes
#SBATCH --ntasks-per-node=4 ### Number of tasks (MPI processes)
#SBATCH --mem=300000 	### Memory(MB)

export PATH=/data/lab/tao/xinyu/software/cuda-11.3/bin:$PATH
export LD_LIBRARY_PATH=/data/lab/tao/xinyu/software/cuda-11.3/lib64:$LD_LIBRARY_PATH
module load python3/3.7.4
module list
source $HOME/env4cv/bin/activate
cd $MYSCRATCH
cd $MYSCRATCH/ACE-SAM
# ===============
#  Step1
# ===============
Lm=( 0.5 )
F0=( 0.6 0.7 )
for lam in "${Lm[@]}" ; 
do
	for f0 in "${F0[@]}" ; 
	do
		time python test_cifar.py --config=./configs/Cifar10.json --work=train --clambda=$lam --f0=$f0
		time python test_cifar.py --config=./configs/Cifar10.json --work=test --clambda=$lam --f0=$f0
	done	
done
