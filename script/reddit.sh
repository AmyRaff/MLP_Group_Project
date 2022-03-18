#!/bin/sh
#SBATCH -N 1	  # nodes requested
#SBATCH -n 1	  # tasks requested
#SBATCH --partition=Teach-Standard
#SBATCH --nodelist=landonia05
#SBATCH --gres=gpu:1
#SBATCH --mem=60000  # memory in Mb
#SBATCH --time=0-08:00:00

export CUDNN_HOME=/opt/cuDNN-7.0/

export STUDENT_ID=$(whoami)

export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH

export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH

export CPATH=${CUDNN_HOME}/include:$CPATH

export PATH=${CUDA_HOME}/bin:${PATH}

#export PYTHON_PATH=$PATH

mkdir -p /disk/scratch/${STUDENT_ID}

export TRANSFORMERS_OFFLINE=1

export TMPDIR=/disk/scratch/${STUDENT_ID}/
export TMP=/disk/scratch/${STUDENT_ID}

python3 ../src/reddit_prep.py

