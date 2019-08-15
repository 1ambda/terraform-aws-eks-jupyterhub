#!/usr/bin/env bash

TAG="[$(basename -- "$0")]"

aws eks update-kubeconfig --name analysis-production

RELEASE=jupyterhub
NAMESPACE=jupyter-production

helm repo update

# https://jupyterhub.github.io/helm-chart/#development-releases-jupyterhub
helm install --name ${RELEASE} jupyterhub/jupyterhub \
  --timeout 600 \
  --namespace ${NAMESPACE} \
  --version 0.8.2 \
  --values ./jupyter.helm-config.yaml

