#!/usr/bin/env bash

aws eks update-kubeconfig --name analysis-production

TAG="[$(basename -- "$0")]"

RELEASE=jupyterhub
NAMESPACE=jupyter-production

echo ""
read -p "${TAG} Do you want to delete jupyterhub helm chart? (y/n): " yn

if [ "$yn" != "y" ]; then
  echo -e "${TAG} Cancelled\n"
  exit 0
fi

helm delete --purge ${RELEASE}

#kubectl delete pvc -n jupyter-production -l app=jupyterhub
#kubectl delete pvc -n jupyter-production -l storage=efs-jupyter
#kubectl delete pv -n jupyter-production -l app=jupyterhub
#kubectl delete pv -n jupyter-production -l storage=efs-jupyter
#
#echo -e "${TAG} List PVC, PV (app=jupyterhub, storage=efs-jupyter)"
#kubectl get pvc -n jupyter-production -l app=jupyterhub
#kubectl get pvc -n jupyter-production -l app=efs-jupyter
#kubectl get pv -n jupyter-production -l app=jupyterhub
#kubectl get pv -n jupyter-production -l app=efs-jupyter



