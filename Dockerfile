FROM public.ecr.aws/lambda/python:3.8
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG MODEL_DIR=./models
RUN mkdir $MODEL_DIR
RUN ls -all



# aws credentials configuration
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

# Added the Transformers cache directory as models
ENV TRANSFORMERS_CACHE=$MODEL_DIR \
    TRANSFORMERS_VERBOSITY=error

# ENV HF_HOME="/home/abhishek/app/hf_cache_home"

# install requirements
RUN yum install git -y && yum -y install gcc-c++
COPY requirements.txt .
RUN pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

COPY ./ ./

COPY lambda_handler.py ${LAMBDA_TASK_ROOT}
ENV PYTHONPATH "${PYTHONPATH}:./"

# WORKDIR ./

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN pip install "dvc[s3]"   # since s3 is the remote storage
RUN pip install awscli
RUN pip install boto3
RUN pip install --upgrade transformers

RUN mkdir bert_uncased_L-2_H-128_A-2
RUN curl -L https://huggingface.co/google/bert_uncased_L-2_H-128_A-2/resolve/main/pytorch_model.bin -o ./bert_uncased_L-2_H-128_A-2/pytorch_model.bin
RUN curl https://huggingface.co/google/bert_uncased_L-2_H-128_A-2/resolve/main/config.json -o ./bert_uncased_L-2_H-128_A-2/config.json
RUN curl https://huggingface.co/google/bert_uncased_L-2_H-128_A-2/resolve/main/tokenizer.json -o ./bert_uncased_L-2_H-128_A-2/tokenizer.json
RUN curl https://huggingface.co/google/bert_uncased_L-2_H-128_A-2/resolve/main/tokenizer_config.json -o ./bert_uncased_L-2_H-128_A-2/tokenizer_config.json


# initialise dvc
RUN dvc init --no-scm -f

# this will set the ~/.aws/config req 
RUN aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
RUN aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
RUN aws configure set default.region $AWS_DEFAULT_REGION

# check if ~/.aws/config set
RUN aws configure list

# # configuring remote server in dvc
RUN dvc remote add -d model-store s3://model-dvc-storage/trained_model/
# RUN aws s3 ls s3://model-dvc-storage/trained_model/
RUN dvc remote modify model-store access_key_id $AWS_ACCESS_KEY_ID
RUN dvc remote modify model-store secret_access_key $AWS_SECRET_ACCESS_KEY
RUN dvc remote modify model-store region $AWS_DEFAULT_REGION


# pulling the trained model
RUN dvc pull trained_model.dvc


# # running the application
RUN python lambda_handler.py
RUN chmod -R 0755 $MODEL_DIR
CMD [ "lambda_handler.lambda_handler"]



