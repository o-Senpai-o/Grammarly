# FROM huggingface/transformers-pytorch-cpu:latest    
# # baseimage
# # copy everything to /app directory
# COPY ./ /app

# # change working directory
# WORKDIR /app

# # install the required libraries
# RUN pip install -r requirements.txt

# # set the envuronment variable
# ENV LC_ALL=C.UTF-8
# ENV LANG=C.UTF-8

# # expose the localhost 8000 to 8000
# EXPOSE 8000

# # run the app using the below commadn promt command, on localhost://8000
# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

FROM huggingface/transformers-pytorch-cpu:latest

COPY ./ /app
WORKDIR /app

# install requirements
RUN pip install "dvc[gdrive]"
RUN pip install -r requirements.txt

# initialise dvc
RUN dvc init --no-scm -f
# configuring remote server in dvc
RUN dvc remote add -d storage gdrive://1dHJbiw5fzNs7cVDby0e5jVyPhv4pgcCg
RUN dvc remote modify storage gdrive_use_service_account true
RUN dvc remote modify storage gdrive_service_account_json_file_path creds.json

# pulling the trained model
RUN dvc pull trained_model.dvc

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# running the application
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
