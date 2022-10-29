# Grammarly


<!-- ABOUT THE PROJECT -->
## ABOUT THE PROJECT
The goal of the project is to understand and build a End-To-End MLOps lifecycle from  model building, monitoring, configurations, testing, packaging, deployment to CI/CD, etc.

![pl](images/frame1.jpg)

<!-- ***********************************************************************************************************************-->

![pl](images/frame2.jpg)

## Part 1: Deep Learning Project

The project that've implemented is a simple deep learning model which predicts whether a given sentence is gramatically correct or not.
  - Input data : 'glue'
  - model : 'google/bert_uncased_L-2_H-128_A-2'
  - output format : 'Probabilities [correct, incorrect]'
  - framework : 'Pytorch-Lightning', 'Huggingface Datasets' , 'Huggingfacemodels'
  
Following tech stack is used:

- [Huggingface Datasets](https://github.com/huggingface/datasets)
- [Huggingface Transformers](https://github.com/huggingface/transformers)
- [Pytorch Lightning](https://pytorch-lightning.readthedocs.io/)

## Part 2: Model monitoring - Weights and Biases

Weight and Biases alone can be used to do many different Mlops tasks like model monitoring, hyperparameter tracking, model and data versioning etc.
But I've used only for tracking model training.

  - plotted model training
  - confusion matrix
  - a table displaying incorrectly classified datapoints
  
![wannb](images/wandB.png)

References:

- [Tutorial on Pytorch Lightning + Weights & Bias](https://www.youtube.com/watch?v=hUXQm46TAKc)
- [WandB Documentation](https://docs.wandb.ai/)
- [Weights and Biases](https://wandb.ai/site)
- [torchmetrics](https://torchmetrics.readthedocs.io/)

## Part 3: Configurations - Hydra

Configuration management is a necessary for managing complex software systems. Lack of configuration management can cause serious problems with reliability, uptime, and the ability to scale a system. Configuration management helps to scale our project with much hassle and have all the tuning requirements at hand.

  - configured model hyperparams

![hydra](images/hydra.png)

References

- [Hydra Documentation](https://hydra.cc/docs/intro)
- Kaggle notebooks/ Competitions solutions

## Part 4: Data Version Control - DVC

Versioning platforms like github can't be used to version large files like model and dataset. This is where DVC(data version control) comes into picture. With DVC we can easily keep track/ version our model and dataset, which itself can be stored at different location like AWS S3, or as simple as a google drive.

![dvc](images/dvc.png)

- [DVC Documentation](https://dvc.org/doc)

- [DVC Tutorial on Versioning data](https://www.youtube.com/watch?v=kLKBcPonMYw)

## Part 5: Model Packaging - ONNX

Why do we need model packaging? Models can be built using any machine learning framework available out there (sklearn, tensorflow, pytorch, etc.). We might want to deploy models in different environments like (mobile, web, raspberry pi) or want to run in a different framework (trained in pytorch, inference in tensorflow).
A common file format to enable AI developers to use models with a variety of frameworks, tools, runtimes, and compilers will help a lot.

This is acheived by a community project `ONNX`.

![ONNX](images/onnx.jpeg)

References

- [Abhishek Thakur tutorial on onnx model conversion](https://www.youtube.com/watch?v=7nutT3Aacyw)
- [Pytorch Lightning documentation on onnx conversion](https://pytorch-lightning.readthedocs.io/en/stable/common/production_inference.html)
- [Huggingface Blog on ONNXRuntime](https://medium.com/microsoftazure/accelerate-your-nlp-pipelines-using-hugging-face-transformers-and-onnx-runtime-2443578f4333)


## Prt 6: Model Packaging - Docker
  A lot of newbie engineers complain that the code doesnt run on their computer but it runs on code-owners computer. This can be because of dependency issue or OS related issues. That is why to share a project we can just package the project and easily share it with others without any dependency problems. Dockers comes in handy for every data scientists because a data science can require a lot of lib to be installed in order to run a project.

So for others to run the applications they have to set up the same environment as it was run on the host side which means a lot of manual configuration and installation of components.

The solution to these limitations is a technology called Containers.

By containerizing/packaging the application, we can run the application on any cloud platform to get advantages of managed services and autoscaling and reliability, and many more.

The most prominent tool to do the packaging of application is Docker 

![Docker](images/docker_flow.png)

References

- [Analytics vidhya blog](https://www.analyticsvidhya.com/blog/2021/06/a-hands-on-guide-to-containerized-your-machine-learning-workflow-with-docker/)


## part 7: CI/CD - GitHub Actions

CI/CD is a method to frequently deliver apps to customers by introducing automation into the stages of app development.

Data Science is a itertive process where we have to keep updating our model and dataset. So whenever a new model is trained and if it performs better than previous version then it has to be replaced with better performing model. Github Actions helps us in automating many intermediate tasks which if done manually would eat up a lot of data scientists time. 

![Docker](images/basic_flow.png)

References

- [Configuring service account](https://dvc.org/doc/user-guide/setup-google-drive-remote)

- [Github actions](https://docs.github.com/en/actions/quickstart)


## Part 8: Container Registry - AWS ECR

A container registry is a place to store container images. A container image is a file comprised of multiple layers which can execute applications in a single instance. Hosting all the images in one stored location allows users to commit, identify and pull images when needed.

Amazon Simple Storage Service (S3) is a storage for the internet. It is designed for large-capacity, low-cost storage provision across multiple geographical regions.

![Docker](images/ecr_flow.png)


## Part 9: Serverless Deployment - AWS Lambda

-----------------------  Coming Soon  ----------------------------


## Part 10: Prediction Monitoring - Kibana

-----------------------  Coming Soon  ----------------------------
