import argparse
import regex as re
import nltk

import torch
from torch.utils.data import Dataset

from transformers import *

def parse_args():
    parser = argparse.ArgumentParser()
    tp = lambda x:list(x.split(','))

    parser.add_argument('--model_type', type=str, required=True,
                        choices=['bert', 'roberta', 'electra', 'albert', 'dbert'])

    args = parser.parse_args()

    return args

def prepare_transformer(args):
    if args.model_type == 'bert':
        pretrained_weights = 'bert-base-uncased'
        model = BertModel.from_pretrained(pretrained_weights, output_hidden_states=True)
        tokenizer = BertTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'roberta':
        pretrained_weights = 'roberta-base'
        model = RobertaModel.from_pretrained(pretrained_weights)
        tokenizer = RobertaTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'albert':
        pretrained_weights = 'albert-base-v2'
        model = AlbertModel.from_pretrained(pretrained_weights)
        tokenizer = AlbertTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'dbert':
        pretrained_weights = 'distilbert-base-uncased'
        model = DistilBertModel.from_pretrained(pretrained_weights)
        tokenizer = DistilBertTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'xlnet':
        pretrained_weights = 'xlnet-base-cased'
        model = XLNetModel.from_pretrained(pretrained_weights)
        tokenizer = XLNetTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'electra':
        pretrained_weights = 'google/electra-small-discriminator'
        model = ElectraModel.from_pretrained(pretrained_weights)
        tokenizer = ElectraTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'gpt':
        pretrained_weights = 'openai-gpt'
        model = OpenAIGPTModel.from_pretrained(pretrained_weights)
        tokenizer = OpenAIGPTTokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'gpt2':
        pretrained_weights = 'gpt2'
        model = GPT2Model.from_pretrained(pretrained_weights)
        tokenizer = GPT2Tokenizer.from_pretrained(pretrained_weights)
    elif args.model_type == 'xl':
        pretrained_weights = 'transfo-xl-wt103'
        model = TransfoXLModel.from_pretrained(pretrained_weights)
        tokenizer = TransfoXLTokenizer.from_pretrained(pretrained_weights)

    return model, tokenizer



if __name__ == "__main__":
    args = parse_args()
    prepare_transformer(args)
