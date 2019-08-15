#!/usr/bin/env bash

aws eks update-kubeconfig --name analysis-production

TAG="[$(basename -- "$0")]"

RELEASE=jupyterhub
NAMESPACE=jupyter-production

kubectl apply -f ./k8s.efs-volume.yaml
kubectl apply -f ./k8s.ebs-storage-class.yaml
