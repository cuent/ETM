#!/usr/bin/env bash

# ETM
dataset=heyday_conversational
data_path=data/heyday_conversational
save_path=results/heyday_conversational
num_topics=80
rho_size=300
emb_size=300
train_embeddings=0
bow_norm=1
coherence=1
diversity=1
mode=train
load_from='results/heyday_conversational/etm_heyday_conversational_K_80_Htheta_800_Optim_adam_Clip_0.0_ThetaAct_relu_Lr_0.005_Bsz_1000_RhoSize_300_trainEmbeddings_1'

# SkipGram
data_file=raw/heyday_conversational/data.csv
emb_file=${data_path}/embeddings.txt
min_count=2
skip_gram=1
workers=25
negative_samples=10
window_size=4
iters=50



if [ $1 = train_emb ]; then train_embeddings=1; fi
if [ $2 ]; then mode=$2; fi

if [ $train_embeddings = 1 ]; then
    python skipgram.py --data_file $data_file --emb_file $emb_file \
                       --dim_rho $rho_size --min_count $min_count --sg $skip_gram \
                       --workers $workers --negative_samples $negative_samples \
                       --window_size $window_size --iters $iters
fi

python main.py --dataset $dataset --data_path $data_path --save_path $save_path \
               --emb_path $emb_file --num_topics $num_topics --rho_size $rho_size \
               --emb_size $emb_size --train_embeddings $train_embeddings \
               --bow_norm $bow_norm --tc $coherence --td $diversity \
               --mode $mode --load_from $load_from