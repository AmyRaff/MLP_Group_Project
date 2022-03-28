#!/bin/sh
#SBATCH -N 1	  # nodes requested
#SBATCH -n 1	  # tasks requested
#SBATCH --partition=Teach-Standard
#SBATCH --gres=gpu:1
#SBATCH --mem=90000  # memory in Mb
#SBATCH --time=0-08:00:00

export CUDNN_HOME=/opt/cuDNN-7.0/

export STUDENT_ID=$(whoami)

export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH

export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH

export CPATH=${CUDNN_HOME}/include:$CPATH

export PATH=${CUDA_HOME}/bin:${PATH}

#export PYTHON_PATH=$PATH

mkdir -p /disk/scratch_big/${STUDENT_ID}

export TRANSFORMERS_OFFLINE=1

export TMPDIR=/disk/scratch_big/${STUDENT_ID}/
export TMP=/disk/scratch_big/${STUDENT_ID}

input=$1

echo "Begin transfer"

src_path=/home/${STUDENT_ID}/MLP_Group_Project/${input} 

rsync --archive --update --compress --progress ${src_path} ${TMPDIR}

echo "Data transferred"

source /home/${STUDENT_ID}/miniconda3/bin/activate kaneko

python3 ../src/reddit_prep.py --input $input 

rm -rf ${TMP}
