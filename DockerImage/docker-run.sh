#!/bin/bash

#Build Docker File
docker build -t htaroowai-demo .

#push to Azure Container Registary
az login
az acr login --name htaroowaidemo
docker tag htaroowai-demo htaroowaidemo.azurecr.io/htaroowai-demo
docker push htaroowaidemo.azurecr.io/htaroowai-demo