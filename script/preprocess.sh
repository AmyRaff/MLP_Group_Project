#!/bin//sh
#SBATCH -N 1      # nodes requested
#SBATCH -n 1      # tasks requested
#SBATCH --partition=Teach-Standard
#SBATCH --gres=gpu:1
#SBATCH --mem=12000  # memory in Mb
#SBATCH --time=0-08:00:00

export CUDA_HOME=/opt/cuda-9.0.176.1/
export CUDNN_HOME=/opt/cuDNN-7.0/
export STUDENT_ID=$(whoami)
export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH
export CPATH=${CUDNN_HOME}/include:$CPATH
export PATH=${CUDA_HOME}/bin:${PATH}
export PYTHON_PATH=$PATH
mkdir -p /disk/scratch/${STUDENT_ID}

export TMPDIR=/disk/scratch/${STUDENT_ID}/
export TMP=/disk/scratch/${STUDENT_ID}/

source /home/${STUDENT_ID}/miniconda3/bin/activate mlp

model_type=$1
data=$2
seed=42
block_size=128

# export TRANSFORMERS_OFFLINE=1	

OUTPUT_DIR=../preprocess/$seed/$model_type
rm -r $OUTPUT_DIR
mkdir -p $OUTPUT_DIR

#python ../src/test.py

python ../src/preprocess.py --input ../data/$data --stereotypes ../data/stereotype.txt --attributes ../data/female.txt,../data/male.txt --output $OUTPUT_DIR --seed $seed --block_size $block_size --model_type $model_type
