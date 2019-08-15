#!/usr/bin/env bash

aws eks update-kubeconfig --name analysis-production

TAG="[$(basename -- "$0")]"

RELEASE=jupyterhub
NAMESPACE=jupyter-production

kubectl delete -f ./k8s.nbviewer-deployment.yaml