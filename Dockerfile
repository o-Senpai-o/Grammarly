FROM huggingface/transformers-pytorch-cpu:latest

# RUN useradd -m abhishek
# RUN chown -R abhishek:abhishek /home/abhishek/
# COPY --chown=abhishek . /home/abhishek/app/
# USER abhishek
# RUN cd /home/abhishek/app/
# WORKDIR /home/abhishek/app/
COPY ./ /app
WORKDIR /app

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION


# aws credentials configuration
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

# ENV HF_HOME="/home/abhishek/app/hf_cache_home"

# install requirements
RUN pip install "dvc[s3]"   # since s3 is the remote storage
RUN pip install -r requirements.txt
RUN pip install awscli
RUN pip install boto3
RUN pip install --upgrade transformers

RUN git lfs install
RUN git clone https://huggingface.co/google/bert_uncased_L-2_H-128_A-2

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
RUN aws s3 ls s3://model-dvc-storage/trained_model/
RUN dvc remote modify model-store access_key_id $AWS_ACCESS_KEY_ID
RUN dvc remote modify model-store secret_access_key $AWS_SECRET_ACCESS_KEY
RUN dvc remote modify model-store region $AWS_DEFAULT_REGION


# pulling the trained model
RUN dvc pull trained_model.dvc

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# # running the application
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
