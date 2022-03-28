#!/bin//sh
#SBATCH -N 1      # nodes requested
#SBATCH -n 1      # tasks requested
#SBATCH --partition=Teach-LongJobs
#SBATCH --gres=gpu:1
#SBATCH --mem=90000  # memory in Mb
#SBATCH --time=1-08:00:00

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
source /home/${STUDENT_ID}/miniconda3/bin/activate kaneko


model_type=$1
gpu=$2
debias_layer=all # first last all
loss_target=token # token sentence
dev_data_size=1000
seed=$3
alpha=0.2
beta=0.8
lr=$4

if [ $model_type = 'bert' ]; then
    model_name_or_path=bert-base-cased
elif [ $model_type = 'roberta' ]; then
    model_name_or_path=roberta-base
elif [ $model_type = 'albert' ]; then
    model_name_or_path=albert-base-v2
elif [ $model_type = 'dbert' ]; then
    model_name_or_path=distilbert-base-uncased
elif [ $model_type = 'electra' ]; then
    model_name_or_path=google/electra-small-discriminator
fi

TRAIN_DATA=../preprocess/$seed/$model_type/data.bin
OUTPUT_DIR=../debiased_models/$seed/$model_type/twodim/$lr/five

rm -r $OUTPUT_DIR
echo $model_type $seed

CUDA_VISIBLE_DEVICES=$gpu python -u ../src/4run.py \
    --output_dir=$OUTPUT_DIR \
    --model_type=$model_type \
    --model_name_or_path=$model_name_or_path \
    --do_train \
    --data_file=$TRAIN_DATA \
    --do_eval \
    --evaluate_during_training \
    --learning_rate $lr \
    --per_gpu_train_batch_size 5 \
    --per_gpu_eval_batch_size 5 \
    --num_train_epochs 3 \
    --block_size 128 \
    --loss_target $loss_target \
    --debias_layer $debias_layer \
    --seed $seed \
    --weighted_loss $alpha $beta \
    --dev_data_size $dev_data_size \
    --square_loss \
    --line_by_line \
    #--max_steps 10000
    
