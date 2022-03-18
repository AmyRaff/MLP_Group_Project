#!/bin/sh
#SBATCH -N 1	  # nodes requested
#SBATCH -n 1	  # tasks requested
#SBATCH --partition=Teach-Standard
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
export TMP=/disk/scratch/${STUDENT_ID}/

echo "Begin transfer"

src_path=/home/${STUDENT_ID}/MLP_Group_Project/data

rsync --archive --update --compress --progress ${src_path}/ ${TMP}

echo "Data transferred" 

model_type=bert
data=clean_RC
#data=news-commentary-v15.en
#data=RC_2017
seed=22
block_size=128
OUTPUT_DIR=../preprocess/$seed/$model_type

rm -r $OUTPUT_DIR
mkdir -p $OUTPUT_DIR

#this hack was the only way I could get the environment to work, just use python3  
~/miniconda3/envs/kaneko/bin/python3 -u ../src/preprocess.py --input $TMP/$data \
                        --stereotypes ../data/cm_stereotype.txt \
                        --attributes ../data/whshort.txt,../data/blshort.txt \
                        --output $OUTPUT_DIR \
                        --seed $seed \
                        --block_size $block_size \
                        --model_type $model_type

rm -r $TMP

